import Foundation
import UIKit
import SwiftyJSON

//[EN]The Entity of the class User is for storage some data about user /[RU] Объект класс User предназанчен для хранения некоторых данных о пользователе
class User: Human {

    //MARK: - Variables
    
    var id: Int
    var name: String
    var lastName: String
    
    ///[EN] URL of the photo /[RU] URL фотографии
    var photoURL: URL?
    
    ///[EN] Photo (UIImage) of the User /[RU] Фотография (UIImage) пользователя
    var photo: UIImage?
    
    ///[EN] Bool variable to check is User Online  /[RU] Bool переменная для проверки онлайн ли пользователь
    var isOnline: Bool = false
    
    //MARK: - Functions
    
    //MARK: - Inits
    
    init() {
        self.id = -1
        self.name = "name"
        self.lastName = "surname"
        self.photo = UIImage(named: "user_male")!
    }
    
    init(id: Int, lastName: String, firstName: String) {
        self.id = id
        self.lastName = lastName
        self.name = firstName
        self.photo = UIImage(named: "user_male")!
    }
    
    init(id: Int, lastName: String, firstName: String, photo: UIImage?) {
        self.id = id
        self.lastName = lastName
        self.name = firstName
        self.photo = photo
    }
    
    init(json: JSON) {
        self.id        = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.lastName  = json["last_name"].stringValue
        self.photoURL  = URL(string: json["photo"].stringValue)
        self.isOnline    = json["online"].boolValue
    }
}
