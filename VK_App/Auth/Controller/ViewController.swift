
import UIKit
import SwiftKeychainWrapper

class ViewController: UIViewController {

    //MARK: - UI Objects
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - View Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        if let userToken = KeychainWrapper.standard.string(forKey: "userToken") {
            VKAuth.token = userToken
            guard let friendView = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
            self.navigationController?.pushViewController(friendView, animated: false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///[EN]Function for authentication of user and then go to the application /[RU]Функция предназначена для аунтификации пользователя и последующему переходу в приложение
    @IBAction func logIning(_ sender: UIButton) {        
        let userDefualts = UserDefaults.standard

        guard let userToken = userDefualts.string(forKey: "userToken") else {
            performSegue(withIdentifier: "loginScreen", sender: nil)
            return
        }
        
        VKAuth.token = userToken

        performSegue(withIdentifier: "loginDone", sender: nil)
    }

    
    ///[EN]Creating Classic Alert. Show the text of Alert and the button "OK" /[RU]Создает Классический Alert. Выводит текст и имеет одну кнопку "ОК" для закрытия Alert'а
    func showAlert(title: String, message: String) {
        let alert = AlertBuilder().createAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
    
    ///[EN]Print to the console entered login and password /[RU]Печатает в консоль введенные логин и пароль
    func printInfoAboutUser(login: String?, password: String?) {
        print("Логин: \(login ?? "Поле ввода логина пустое")" )
        print("Пароль: \(password ?? "Поле ввода пароля пустое")" )
    }

}

