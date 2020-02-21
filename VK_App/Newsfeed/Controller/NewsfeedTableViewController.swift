//
//  NewsfeedTableViewController.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {

    var posts = [VKPost]()
    var groups = [VKGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.cellIdentifier)
        tableView.estimatedRowHeight = 1000
        
        VKNewsFeed().get(startFrom: nil) { [weak self] (response) in
            defer {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            self?.posts = response.response.items
            self?.groups = response.response.groups
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier, for: indexPath) as? PostTableViewCell
        else { return UITableViewCell() }

        let post = posts[indexPath.row]
        let group = groups.first(where: {$0.id == post.sourceId || -$0.id == post.sourceId})
        cell.set(post: post, group: group)
        
        return cell
    }

}
