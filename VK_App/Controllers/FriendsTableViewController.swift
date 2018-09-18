
import UIKit

class FriendsViewController: UITableViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var users: [User] = [User(id: 1, surname: "Wright",   name: "Mill",   age: 21, avatar: UIImage(named: "mill")!   ),
                         User(id: 2, surname: "Yushkova", name: "Regina", age: 21, avatar: UIImage(named: "regina")! ),
                         User(id: 3, surname: "Morozov",  name: "Dmitry", age: 19, avatar: UIImage(named: "dmitry")! )]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VK_API().getUserFriendList(user_id: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    ///Определяет количество столбцов в TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ///Определяет количество строк в TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    /// Заполнение строчек в TableView информацией (текстом из #userStories)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUS", for: indexPath)
        
        guard let nameFriendLabel: UILabel = cell.viewWithTag(1) as? UILabel     else { return cell }
        guard let imageFriend: UIImageView = cell.viewWithTag(2) as? UIImageView else { return cell }
        
        nameFriendLabel.text = users[indexPath.row].getFullName()
        imageFriend.image = users[indexPath.row].avatar
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    /// Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableview.indexPathForSelectedRow else { return }
        if(segue.identifier == "toStory"){
            let datailVC = segue.destination as! ImagesFriendViewController
            datailVC.user = users[indexPath.row]
        }
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
}
