
import Foundation
import UIKit
///AlertFactory реализует создание и отображение Alert
class AlertFactory: AlertProtocol {
    
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
    func showAlert(parentViewController viewControllerToPresent: UIViewController, alert: UIAlertController) {
        viewControllerToPresent.present(alert, animated: true, completion: nil)
    }
    
    init() {
        
    }
    
}
