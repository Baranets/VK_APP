
import UIKit

class ViewController: UIViewController {

    //MARK: - UI Objects
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - View Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///[EN]Function for authentication of user and then go to the application /[RU]Функция предназначена для аунтификации пользователя и последующему переходу в приложение
    @IBAction func logIning(_ sender: UIButton) {
    /*
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
    */
        performSegue(withIdentifier: "logined", sender: nil)
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

