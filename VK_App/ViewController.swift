//
//  ViewController.swift
//  VK_App
//
//  Created by Maxim on 19.08.2018.
//  Copyright © 2018 Maxim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //coming soon
    @IBAction func logIning(_ sender: UIButton) {
        printInfoAboutUser()
    }
    
    func printInfoAboutUser() {
        print("Логин: \(loginTextField.text ?? "Поле ввода логина пустое")" )
        print("Пароль: \(passwordTextField.text ?? "Поле ввода пароля пустое")" )
    }

}

