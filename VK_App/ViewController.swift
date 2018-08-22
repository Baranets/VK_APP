//
//  ViewController.swift
//  VK_App
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
    
    ///Функция предназначена для аунтификации пользователя и последующему переходу в приложение
    @IBAction func logIning(_ sender: UIButton) {
        guard let login = loginTextField.text else {
            createAlert(title: "Ошибка авторизации", message: "Логин не обнаружен")
            return
        }
        
        guard let password = passwordTextField.text else {
            createAlert(title: "Ошибка авторизации", message: "Пароль не обнаружен")
            return
        }
        
        guard login != "" || password != "" else {
            createAlert(title: "Ошибка авторизации", message: "Логин или пароль не указаны")
            return
        }
        
        printInfoAboutUser(login: login, password: password)
        performSegue(withIdentifier: "logined", sender: nil)
    
    }
    
    ///Создает Классический Alert. Выводит текст и имеет одну кнопку "ОК" для закрытия Alert'а
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    ///Печатает в консоль введенные логин и пароль
    func printInfoAboutUser(login: String?, password: String?) {
        print("Логин: \(login ?? "Поле ввода логина пустое")" )
        print("Пароль: \(password ?? "Поле ввода пароля пустое")" )
    }

}

