
import UIKit



class GroupsWorldViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableview: UITableView!
    
    var groups: [Group] = [Group(name: "MDK", countSubscribers: 10_000_000), Group(name: "Svobodnii ot zabot", countSubscribers: 500_000)]
    var filteredGroups = [Group]()
    
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notUserGroup", for: indexPath)

        guard let groupNameLabel = cell.viewWithTag(1)     as? UILabel     else { return cell }
        guard let groupCountSubLabel = cell.viewWithTag(2) as? UILabel     else { return cell }
        guard let groupImage = cell.viewWithTag(3)         as? UIImageView else { return cell }
        
        groupNameLabel.text = filteredGroups[indexPath.row].name
        groupCountSubLabel.text = "\(filteredGroups[indexPath.row].countSubscribers)"
        groupImage.image = filteredGroups[indexPath.row].image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        //TODO: - реализовать добавление новой группы
        navigationController?.popViewController(animated: true)
    }
    
}

extension GroupsWorldViewController: UISearchBarDelegate {
    
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
