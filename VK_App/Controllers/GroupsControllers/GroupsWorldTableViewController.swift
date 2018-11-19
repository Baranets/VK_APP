import UIKit

class GroupsWorldViewController: UITableViewController {

    //MARK: - UI Objects

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableview: UITableView!
    
    //MARK: - Variables
    
    ///[EN]Array with filtered list of groups /[RU]Массив с отфильтрованным списком групп
    var filteredGroups = [Group]()
    
    ///[EN]Cache for Photos /[RU]Кэш для фотографий
    var photoCache = NSCache<AnyObject, AnyObject>()
    
    //MARK: - View Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell, let indexPath = tableview.indexPath(for: cell) else {
            return
        }
        
        DispatchQueue.global().async {
            VK_Group().joinGroup(byGroupID: self.filteredGroups[indexPath.row].id)
            DispatchQueue.main.async {
                sender.isHidden = true
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notUserGroup", for: indexPath)

        guard let groupNameLabel = cell.viewWithTag(1) as? UILabel     else { return cell }
        guard let groupImage = cell.viewWithTag(2)     as? UIImageView else { return cell }
        
        let group = filteredGroups[indexPath.row]
        groupNameLabel.text = group.name
        
        if let imageFromCache = photoCache.object(forKey: group.photoURL as AnyObject) as? UIImage {
            groupImage.image = imageFromCache
        } else {
            groupImage.downloadPhoto(fromURL: group.photoURL, imageCache: photoCache)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Extension UISearchBarDelegate

extension GroupsWorldViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGroups.removeAll()
            tableview.reloadData()
            return
        } else {
            VK_Group().getSearchGroups(by: searchText, completion: { [weak self] groups in
                self?.filteredGroups = groups
                self?.tableview.reloadData()
            })
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //Probably in the future
    }
}
