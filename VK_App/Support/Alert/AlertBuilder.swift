import Foundation
import UIKit

///[EN]Class for creating Alerts /[RU]Класс для создания Alert'ов
class AlertBuilder {
    
    ///[EN]Create Alert from input paramets "title" and "message" /[RU]Создает Alert из входных параметров "title" и "message"
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
}
