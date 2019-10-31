import UIKit
import RealmSwift
import AlamofireImage

class GroupsViewController: UITableViewController {
    
    //MARK: - UI Objects
    
    @IBOutlet var tableview: UITableView!
    let searchBarController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()
    
    let realm = try! Realm()
    var groups: Results<Group>?
    
//    ///[EN]Array with full list of groups of the user /[RU]Массив с полным списком групп пользователя
//    var groups         = [Group]()
//    ///[EN]Array with filtered list of groups /[RU]Массив с отфильтрованным списком групп
//    var filteredGroups = [Group]()
    
    ///[EN]Cache for Photos /[RU]Кэш для фотографий
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 16 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 8 * 1024 * 1024
    )
    
    let refreshcontrol = UIRefreshControl()
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groups = loadRealmData()
   
        refreshcontrol.addTarget(self, action: #selector (GroupsViewController.loadData), for: UIControl.Event.valueChanged)
        
        tableview.refreshControl = self.refreshcontrol
        
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = searchBarController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        searchBarController.searchBar.delegate = self
        
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarController.dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroups", for: indexPath)
        
        if !self.tableview.refreshControl!.isRefreshing {
            guard let groupNameLabel: UILabel = cell.viewWithTag(1) as? UILabel     else { return cell}
            guard let groupImage: UIImageView = cell.viewWithTag(2) as? UIImageView else { return cell}
            
            guard let group = groups?[indexPath.row] else { return cell }
            
            groupNameLabel.text = group.name
            
            guard let url = URL(string: group.urlPhotoString ?? "") else { return cell }
    
            groupImage.downloadImage(fromURL: url, imageCache: imageCache)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        //[EN]Handling an event with deleting an object from the UITableView /[RU]Обработка события с удалением объект из UITableView
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = self.groups?[indexPath.row] else { return }
            VK_Group().leaveGroup(byGroupID: group.id) { [weak self] in
                try! self?.realm.write {
                    self?.realm.delete(group)
                    self?.tableview.deleteRows(at: [indexPath], with: .fade)
                }
            }
  
        }
    }
    
 
    // Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func loadData() {
        VK_Group().getUserGroups(user_id: nil, completion: {[weak self] groups in
            self?.writeData(groups: groups) {
                self?.tableview.reloadData()
                self?.tableview.refreshControl?.endRefreshing()
            }
        })
    }
    
    
    private func writeData(groups: [Group], completion: @escaping(() -> Void)) {
        try! realm.write {
            realm.add(groups, update: .modified)
            completion()
        }
    }
    
    private func loadRealmData() -> Results<Group>  {
        return realm.objects(Group.self).sorted(byKeyPath: "name", ascending: true)
    }
    
}

//MARK: - Extension UISearchBarDelegate

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty, let text = searchBar.text else {
            groups = self.loadRealmData()
            tableview.reloadData()
            return
        }
        
        groups = self.loadRealmData().filter("name contains '\(text )'")
        tableview.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        groups = self.loadRealmData()
        tableview.reloadData()
    }
    

}
