
import UIKit
import AlamofireImage
import RealmSwift

class FriendsViewController: UITableViewController {

    //MARK: - UI Objects
    
    @IBOutlet var tableview: UITableView!
    
    //MARK: - Variables
    
    let refreshcontrol = UIRefreshControl()
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 48 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 32 * 1024 * 1024
    )
    
    var realm = try! Realm()
    var users: Results<User>?
  
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = self.realm.objects(User.self).sorted(byKeyPath: "lastName", ascending: true)

        refreshcontrol.tintColor = UIColor.black
        refreshcontrol.addTarget(self, action: #selector(FriendsViewController.loadData), for: UIControl.Event.valueChanged)
        tableview.refreshControl = self.refreshcontrol
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUS", for: indexPath)
        
        if !self.tableview.refreshControl!.isRefreshing {
            guard let nameFriendLabel: UILabel = cell.viewWithTag(1) as? UILabel     else { return cell }
            guard let imageFriend: UIImageView = cell.viewWithTag(2) as? UIImageView else { return cell }
            guard let onlineFriendLabel: UILabel = cell.viewWithTag(3) as? UILabel     else { return cell }
            
            guard let user = users?[indexPath.row] else { return cell }
            nameFriendLabel.text = user.fullName
            onlineFriendLabel.text = (user.isOnline) ? "online" : "offline"
            onlineFriendLabel.textColor = (user.isOnline) ? UIColor.green : UIColor.gray
            guard let url = URL(string: user.urlPhotoString ?? "") else { return cell }
            imageFriend.downloadPhoto(fromURL: url, imageCache: imageCache)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let userForDelete = users?[indexPath.row] else { return }
            do {
                try realm.write {
                    realm.delete(userForDelete)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            } catch (let error) {
                print(error)
            }
        }
    }


    @objc private func loadData() {
        VK_User().getUserFriendList(user_id: nil, completion: ({[weak self] users in
            self?.writeData(users: users) {
                self?.tableview.reloadData()
                self?.tableview.refreshControl?.endRefreshing()
            }
        }))
    }
    
    private func writeData(users: [User]?, completion: @escaping(() -> Void)) {
        do {
            guard let users = users else {
                completion()
                return
            }
            try self.realm.write {
                realm.add(users, update: true)
                completion()
            }
        } catch(let error) {
            print(error)
            return
        }
    }
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableview.indexPathForSelectedRow else { return }
        if(segue.identifier == "toStory") {
            let datailVC = segue.destination as! ImagesFriendViewController
            datailVC.user = users?[indexPath.row]
        }
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
}
