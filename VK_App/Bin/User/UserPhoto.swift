import Foundation
import UIKit
import SwiftyJSON

///[EN]Class is for storage data about photo of the user [RU]Класс предназначен для хранения информации о фото пользователя
class UserPhoto {
    
    //MARK: - Variables
    
    ///[EN]Identification number of the Photo /[RU]Идентификационный номер фотографии
    var id:    Int
    
    ///[EN]URL of the Photo /[RU]URL Фотографии
    var url:   URL
    
    //MARK: - Inits
    
    required init() {
        self.id = 0
        self.url = URL(fileURLWithPath: "")
    }
    
    init(id: Int, url: URL) {
        self.id  = id
        self.url = url
    }
    
    init(json: JSON) {
        self.id   = json["id"].intValue
        self.url  = URL(string: json["sizes"][0]["url"].stringValue)!
    }
    
}
