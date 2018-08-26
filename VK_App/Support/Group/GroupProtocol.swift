
import Foundation
import UIKit

///Проток Группа (GroupProtocol) оперделяет переменные и методы
protocol GroupProtocol {
    
    ///Имя Группы
    var name: String    { get }
    ///Изображение Группы
    var image: UIImage  { get }
    ///Количество Подписчиков
    var countSubscribers: Int { get }
    
    ///Загрузить из сети интернет новости Группы
    func downloadNews()
    
}
