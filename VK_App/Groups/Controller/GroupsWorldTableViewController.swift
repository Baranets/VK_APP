import UIKit

class GroupsWorldViewController: UITableViewController {

    // MARK: - UI Objects

    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Variables
    
    ///[EN]Array with filtered list of groups /[RU]Массив с отфильтрованным списком групп
    var filteredGroups = [VKGroup]()
    
    // MARK: - View Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100  
        tableView.register(GroupTableViewCell.nib, forCellReuseIdentifier: GroupTableViewCell.cellIdentifier)
        
        searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling   = false
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.cellIdentifier) as? GroupTableViewCell
        else { return UITableViewCell() }
        
        let group = filteredGroups[indexPath.row]
        cell.group = group
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Extension UISearchBarDelegate

extension GroupsWorldViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGroups.removeAll()
            tableView.reloadData()
        } else {
            VKGroupRequest().search(by: searchText, completion: { [weak self] response in
                self?.filteredGroups = response.response.items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //Probably in the future
    }
}
