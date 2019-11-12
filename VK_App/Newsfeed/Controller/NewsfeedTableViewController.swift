//
//  NewsfeedTableViewController.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {

    var posts = [Post]()
    var groups = [Group]()
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableView.automaticDimension
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.cellIdentifier)
//        tableView.estimatedRowHeight = 1000
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.separatorStyle = .none

        VKNewsFeed().get(startFrom: nil) { [weak self] (posts, groups) in
            defer {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            guard let posts = posts,
                let groups = groups else { return }
            
            self?.posts = posts
            self?.groups = groups
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier, for: indexPath) as! PostTableViewCell

        let post = posts[indexPath.row]
        let group = groups.first(where: {$0.id == post.sourceId || -$0.id == post.sourceId})
        cell.set(post: post, group: group)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
