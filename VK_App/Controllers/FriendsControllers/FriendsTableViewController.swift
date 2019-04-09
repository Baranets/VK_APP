
import UIKit
import AlamofireImage

class FriendsViewController: UITableViewController {

    //MARK: - UI Objects
    
    @IBOutlet var tableview: UITableView!
    
    //MARK: - Variables
    
    let refreshcontrol = UIRefreshControl()
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 48 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 32 * 1024 * 1024
    )
    var users = [User]()
  
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshcontrol.tintColor = UIColor.white
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
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUS", for: indexPath)
        
        if !self.tableview.refreshControl!.isRefreshing {
            guard let nameFriendLabel: UILabel = cell.viewWithTag(1) as? UILabel     else { return cell }
            guard let imageFriend: UIImageView = cell.viewWithTag(2) as? UIImageView else { return cell }
            guard let onlineFriendLabel: UILabel = cell.viewWithTag(3) as? UILabel     else { return cell }
            
            let user = users[indexPath.row]
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
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    @objc private func loadData() {
        VK_User().getUserFriendList(user_id: nil, completion: ({[weak self] users in
            self?.users = users
            self?.users.sort(by: { $0.lastName < $1.lastName })
            self?.tableview.reloadData()
            self?.tableview.refreshControl?.endRefreshing()
        }))
    }
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableview.indexPathForSelectedRow else { return }
        if(segue.identifier == "toStory") {
            let datailVC = segue.destination as! ImagesFriendViewController
            datailVC.user = users[indexPath.row]
        }
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
}
