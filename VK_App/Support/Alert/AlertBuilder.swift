import Foundation
import UIKit

///Класс занимается созданием Alert'ов
class AlertBuilder {
    
    ///Создает Alert из входных параметров title и message
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
}
