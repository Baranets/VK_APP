import UIKit
import RealmSwift

class FriendsViewController: UITableViewController {

    // MARK: - Variables
    
    var friends: Results<VKFriend>?
    var notificationToken: NotificationToken?
  
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    // MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FriendTableViewCell.nib,
                           forCellReuseIdentifier: FriendTableViewCell.cellIdentifier)
        tableView.register(FriendTableViewCellCode.self,
                           forCellReuseIdentifier: FriendTableViewCellCode.cellIdentifier)
        tableView.estimatedRowHeight = 600

        let refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(FriendsViewController.loadData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshcontrol
        
        do {
            try configureRealm()
        } catch let error {
            print(error)
            print(error.localizedDescription)
        }
        
        loadData()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func configureRealm() throws {
        let realm = try Realm()
        friends = realm.objects(VKFriend.self).sorted(byKeyPath: "lastName", ascending: true)

        notificationToken = friends?.observe { [weak self] (changes: RealmCollectionChange) in
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
        return friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FriendTableViewCellCode.preferredRowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCellCode.cellIdentifier, for: indexPath) as? FriendTableViewCellCode
        else { return UITableViewCell() }

        guard let user = friends?[indexPath.row] else { return cell }
        cell.friend = user
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard
                let friendDelete = friends?[indexPath.row],
                let realm = try? Realm()
            else { return }
            
            try? realm.write {
                realm.delete(friendDelete)
            }
        }
    }

    @objc private func loadData() {
        VKRequestFactory(viewController: self).loadFriendList(by: nil)
    }
   
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "toStory" {
            guard let datailVC = segue.destination as? ImagesFriendViewController else { return }
            datailVC.user = friends?[indexPath.row]
        }
    }
    
}
