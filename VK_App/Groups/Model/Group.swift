import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class Group: Object, Entity {

    //MARK: - Variables
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var urlPhotoString: String?
    @objc dynamic var urlLargePhotoString: String?
    @objc dynamic var isMember: Bool = false
    
    ///[EN] URL of the group image(large) /[RU] URL фотографии(большой) группы
    var smallPhotoURL: URL? {
        return URL(string: urlPhotoString ?? "")
    }
    
    var largePhotoURL: URL? {
        return URL(string: urlLargePhotoString ?? "")
    }
    
    ///[EN] Large Photo (UIImage) of the Group /[RU] Большая Фотография (UIImage) Группы
    var largePhoto: UIImage?
    var countSubscribers: Int?
    
    //MARK: - Inits
    
    convenience init(json: JSON) {
        self.init()
        self.id            = json["id"].intValue
        self.name          = json["name"].stringValue
        self.urlPhotoString = json["photo_50"].stringValue
        self.urlLargePhotoString = json["photo_200"].stringValue
        self.isMember = json["is_member"].boolValue
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}
