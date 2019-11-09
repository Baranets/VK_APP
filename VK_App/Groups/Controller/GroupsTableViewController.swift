import UIKit
import RealmSwift
import AlamofireImage

class GroupsViewController: UITableViewController {
    
    //MARK: - UI Objects
    let searchBarController = UISearchController(searchResultsController: nil)
    
    let realm = try! Realm()
    var groups: Results<Group>?
    var notificationToken: NotificationToken?
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarController.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: GroupTableViewCell.cellIdentifire, bundle: nil), forCellReuseIdentifier: GroupTableViewCell.cellIdentifire)
        
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector (GroupsViewController.loadData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshcontrol
        
        self.navigationItem.searchController = searchBarController
        searchBarController.searchBar.delegate = self
        searchBarController.dimsBackgroundDuringPresentation = false
        
        configureRealm()
        
        loadData()
    }
    
    deinit {
        notificationToken?.invalidate()
        realm.invalidate()
    }
    
    private func configureRealm() {
        groups = loadRealmData()

        notificationToken = groups?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                        with: .automatic)
                self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                        with: .none)
                self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                        with: .none)
                self?.tableView.endUpdates()
                
            case .error(let error):
                print(error)
            }
            self?.tableView.refreshControl?.endRefreshing()

        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.cellIdentifire) as! GroupTableViewCell
        
        cell.group = groups?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        //[EN]Handling an event with deleting an object from the UITableView /[RU]Обработка события с удалением объект из UITableView
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = self.groups?[indexPath.row] else { return }
            VKGroup().leave(groupId: group.id) { [weak self] in
                try! self?.realm.write {
                    self?.realm.delete(group)
                }
            }
  
        }
    }
    
 
    // Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func loadData() {
        VKGroup().get(userId: nil, completion: {[weak self] groups in
            try! self?.realm.write {
                self?.realm.add(groups, update: .all)
            }
        })
    }
    
    
    private func loadRealmData() -> Results<Group>  {
        return realm.objects(Group.self).sorted(byKeyPath: "name", ascending: true)
    }
    
}

//MARK: - Extension UISearchBarDelegate

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty, let text = searchBar.text else {
            groups = loadRealmData()
            tableView.reloadData()
            return
        }
        
        groups = loadRealmData().filter("name contains '\(text)'")
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        groups = loadRealmData()
        tableView.reloadData()
    }
    

}
