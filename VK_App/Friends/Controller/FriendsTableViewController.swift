import UIKit
import AlamofireImage
import RealmSwift

class FriendsViewController: UITableViewController {

    //MARK: - Variables
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 48 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 32 * 1024 * 1024
    )
    
    var realm = try! Realm()
    var users: Results<User>?
    var notificationToken: NotificationToken?
  
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: FriendTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: FriendTableViewCell.cellIdentifier)
        tableView.estimatedRowHeight = 600

        let refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(FriendsViewController.loadData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshcontrol
        
        configureRealm()
        
        loadData()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func configureRealm() {
        users = self.realm.objects(User.self).sorted(byKeyPath: "lastName", ascending: true)

        notificationToken = users?.observe { [weak self] (changes: RealmCollectionChange) in
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.cellIdentifier, for: indexPath) as! FriendTableViewCell

        guard let user = users?[indexPath.row] else { return cell }
        cell.user = user
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let userForDelete = users?[indexPath.row] else { return }
            do {
                try realm.write {
                    realm.delete(userForDelete)
                }
            } catch (let error) {
                print(error)
            }
        }
    }


    @objc private func loadData() {
        VKFriends().get(user_id: nil) { [weak self] users in
            try! self?.realm.write {
                self?.realm.add(users, update: .all)
            }
        }
    }
   
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "toStory" {
            let datailVC = segue.destination as! ImagesFriendViewController
            datailVC.user = users?[indexPath.row]
        }
    }
    
}
