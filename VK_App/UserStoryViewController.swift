//
//  UserStoryViewController.swift
//  VK_App
//
//  Created by Maxim on 22.08.2018.
//  Copyright © 2018 Maxim. All rights reserved.
//

import UIKit

class UserStoryViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    let userStories = ["first", "second", "third"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return userStories.count
    }
    
    /// Заполнение строчек в TableView информацией (текстом из #userStories)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUS", for: indexPath)
        cell.textLabel?.text = userStories[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    /// Метод предназначен для дальнейшей навигации по UI в зависимости от нажатой строчки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: "toStory", sender: nil)
        default:
            print("Comming Soon", "There is nothing to see")
        }
    }

}
