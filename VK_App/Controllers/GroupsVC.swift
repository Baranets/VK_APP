
import UIKit

class GroupsViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [Group] = [Group(name: "dev/null", countSubscribers: 1_000_000), Group(name: "dev/kek", countSubscribers: 1_000_000_000)]
    var filteredGroups = [Group]()

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredGroups = groups
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    ///Определяет количество столбцов в TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    ///Определяет количество строк в TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }
    
    /// Заполнение строчек в TableView информацией (текстом из #userStories)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroups", for: indexPath)
        
        guard let groupNameLabel: UILabel = cell.viewWithTag(1) as? UILabel     else { return cell}
        guard let groupImage: UIImageView = cell.viewWithTag(2) as? UIImageView else { return cell}
        
        groupImage.image = filteredGroups[indexPath.row].image
        groupNameLabel.text = filteredGroups[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    /// Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredGroups = groups
            tableview.reloadData()
            return}
        filteredGroups = groups.filter({ group -> Bool in
            guard let text = searchBar.text else { return false }
            return group.name.contains(text)
        })
        tableview.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //Probably in the future
    }
}
