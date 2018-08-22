//
//  SometingTableViewController.swift
//  VK_App
//
//  Created by Maxim on 22.08.2018.
//  Copyright © 2018 Maxim. All rights reserved.
//

import UIKit

class SometingTableViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!

    let rows = ["Get Start", "Quit"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return rows.count
    }
    
    /// Заполнение строчек в TableView информацией (текстом из #userStories)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSE", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    
    /// Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: "toSomething1", sender: nil)
        default:
            print("Comming Soon", "There is nothing to see")
        }
    }
    

}
