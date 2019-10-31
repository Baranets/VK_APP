import UIKit
import AlamofireImage

class GroupsWorldViewController: UITableViewController {

    //MARK: - UI Objects

    @IBOutlet var tableview: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Variables
    
    ///[EN]Array with filtered list of groups /[RU]Массив с отфильтрованным списком групп
    var filteredGroups = [Group]()
    
    //MARK: - View Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling   = false
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
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
        
        guard let url = URL(string: group.urlPhotoString ?? "") else { return cell }
        groupImage.downloadImage(fromURL: url, imageCache: nil)
        
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
