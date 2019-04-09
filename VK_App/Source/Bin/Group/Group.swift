import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class Group: Object, Entity {

    //MARK: - Variables
    
    @objc dynamic var name: String = ""
    @objc dynamic var urlPhotoString: String?
    
    ///[EN]Identification number of the Group /[RU]Идентификационный номер группы
    @objc dynamic var id: Int = 0
    
    ///[EN] URL of the group image(large) /[RU] URL фотографии(большой) группы
    var largePhotoURL: URL?
    
    ///[EN] Large Photo (UIImage) of the Group /[RU] Большая Фотография (UIImage) Группы
    var largePhoto: UIImage?
    var countSubscribers: Int?
    
    //MARK: - Inits
    
    convenience init(json: JSON) {
        self.init()
        self.id            = json["id"].intValue
        self.name          = json["name"].stringValue
        self.urlPhotoString = json["photo_50"].stringValue
        self.largePhotoURL = URL(string: json["photo_200"].stringValue)
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}
