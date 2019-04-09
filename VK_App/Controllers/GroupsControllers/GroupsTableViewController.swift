import UIKit
import AlamofireImage

class GroupsViewController: UITableViewController {
    
    //MARK: - UI Objects
    
    @IBOutlet var tableview: UITableView!
    let searchBarController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()
    
    //MARK: - Variables
    
    ///[EN]Array with full list of groups of the user /[RU]Массив с полным списком групп пользователя
    var groups         = [Group]()
    ///[EN]Array with filtered list of groups /[RU]Массив с отфильтрованным списком групп
    var filteredGroups = [Group]()
    
    ///[EN]Cache for Photos /[RU]Кэш для фотографий
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 48 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 32 * 1024 * 1024
    )
    
    let refreshcontrol = UIRefreshControl()
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadItems()
        
        refreshcontrol.addTarget(self, action: #selector (GroupsViewController.refreshData), for: UIControl.Event.valueChanged)
        
        tableview.refreshControl = self.refreshcontrol
        
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = searchBarController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        searchBarController.searchBar.delegate = self

//        navigationItem.titleView = searchBar
//        searchBar.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarController.dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroups", for: indexPath)
        
        if !self.tableview.refreshControl!.isRefreshing {
            guard let groupNameLabel: UILabel = cell.viewWithTag(1) as? UILabel     else { return cell}
            guard let groupImage: UIImageView = cell.viewWithTag(2) as? UIImageView else { return cell}
            
            let group = filteredGroups[indexPath.row]
            
            groupNameLabel.text = group.name
            
            guard let url = URL(string: group.urlPhotoString ?? "") else { return cell }
    
            groupImage.downloadPhoto(fromURL: url, imageCache: imageCache)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        //[EN]Handling an event with deleting an object from the UITableView /[RU]Обработка события с удалением объект из UITableView
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupID = self.filteredGroups[indexPath.row].id
            DispatchQueue.global().async {
                self.filteredGroups.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.tableview.deleteRows(at: [indexPath], with: .fade)
                }
            }
            DispatchQueue.global().async {
                VK_Group().leaveGroup(byGroupID: groupID)
                DispatchQueue.main.async {
                    self.searchBarController.searchBar.text = ""
                    self.refreshData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    // Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Extension UISearchBarDelegate

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredGroups = groups
            tableview.reloadData()
            return}
        filteredGroups = groups.filter({ group -> Bool in
            guard let text = searchBar.text?.lowercased() else { return false }
            return group.name.lowercased().contains(text)
        })
        tableview.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    private func downloadItems() {
        VK_Group().getUserGroups(user_id: nil, completion: {[weak self] groups in
            self?.groups = groups
            self?.filteredGroups = groups
            self?.tableview.reloadData()
            self?.tableview.refreshControl?.endRefreshing()
        })
    }
}

//MARK: - Functions for UIRefreshControl
extension GroupsViewController {
    
    ///Download data and refresh the UITableView
    @objc func refreshData() {
        groups.removeAll()
        filteredGroups.removeAll()
        downloadItems()
    }
    
}
