
import Foundation
import UIKit

///Протокол Alert небходим для структурирования всего связанного с Alert
protocol AlertProtocol {
    
    ///Создает экземпляр UIAlertController
    func createAlert(title: String, message: String) -> UIAlertController

    ///Отображает на указанном экране Alert
    func showAlert(parentViewController viewControllerToPresent: UIViewController, alert: UIAlertController)
    
}

