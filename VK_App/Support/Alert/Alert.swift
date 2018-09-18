import Foundation
import UIKit

class Alert: UIAlertController {

    func showAlert(parentViewController viewControllerToPresent: UIViewController, alert: UIAlertController) {
        viewControllerToPresent.present(alert, animated: true, completion: nil)
    }

}
