import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

//[EN]The Entity of the class User is for storage some data about user /[RU] Объект класс User предназанчен для хранения некоторых данных о пользователе
class User: Object, Human {

    //MARK: - Variables
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var urlPhotoString: String? = ""
    @objc dynamic var isOnline: Bool = false
    

    //MARK: - Inits
    
    convenience init(json: JSON) {
        self.init()
        
        self.id       = json["id"].intValue
        self.name     = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.isOnline = json["online"].boolValue
        self.urlPhotoString = json["photo"].stringValue
    }
    
    //MARK: - Functions
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["id"]
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.isOnline == rhs.isOnline && lhs.lastName == rhs.lastName && lhs.name == rhs.name && lhs.urlPhotoString == rhs.urlPhotoString
    }
}
