import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

///[EN]Class is for storage data about photo of the user [RU]Класс предназначен для хранения информации о фото пользователя
class UserPhoto: Object {
    
    //MARK: - Variables
    
    ///[EN]Identification number of the Photo /[RU]Идентификационный номер фотографии
    @objc dynamic var id: Int = 0
    
    ///[EN]URL of the Photo /[RU]URL Фотографии
    @objc dynamic var urlString: String = ""
    
    //MARK: - Inits
    convenience init(json: JSON) {
        self.init()
        self.id         = json["id"].intValue
        self.urlString  = json["sizes"][0]["url"].stringValue
    }
    
}
