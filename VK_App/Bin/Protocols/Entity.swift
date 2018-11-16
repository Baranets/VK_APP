import Foundation
import UIKit

///[EN]Protocol with standard fields for Entity /[RU]Протокол со стандартными полями для сущности
protocol Entity {
    
    //MARK: - Variables
    
    ///[EN] Name of Entity /[RU] Имя объекта
    var name:  String  { get }
    
    ///[EN] Image(UIImage) of Entity /[RU] Изображение объекта
    var photo: UIImage? { get }
    
}
