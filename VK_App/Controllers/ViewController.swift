
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
            showAlert(title: "Ошибка авторизации", message: "Логин не обнаружен")
            return
        }
        
        guard let password = passwordTextField.text else {
            showAlert(title: "Ошибка авторизации", message: "Пароль не обнаружен")
            return
        }
        
        guard login != "" && password != "" else {
            showAlert(title: "Ошибка авторизации", message: "Логин или пароль не указаны")
            return
        }
        
        printInfoAboutUser(login: login, password: password)
        performSegue(withIdentifier: "logined", sender: nil)
    
    }
    
    ///Создает Классический Alert. Выводит текст и имеет одну кнопку "ОК" для закрытия Alert'а
    func showAlert(title: String, message: String) {
        let alertFactory = AlertFactory()
        let alert = alertFactory.createAlert(title: title, message: message)
        alertFactory.showAlert(parentViewController: self, alert: alert)
    }
    
    ///Печатает в консоль введенные логин и пароль
    func printInfoAboutUser(login: String?, password: String?) {
        print("Логин: \(login ?? "Поле ввода логина пустое")" )
        print("Пароль: \(password ?? "Поле ввода пароля пустое")" )
    }

}

