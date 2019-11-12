import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

///[EN]Class is for storage data about photo of the user [RU]Класс предназначен для хранения информации о фото пользователя
class Photo: Object {
    
    //MARK: - Variables
    @objc dynamic var id: Int = 0
    @objc dynamic var albumId: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var userId: Int = 0
    let sizes = List<Sizes>()
    
    //MARK: - Inits
    convenience init(json: JSON) {
        self.init()
        self.id         = json["id"].intValue
        self.albumId    = json["album_id"].int ?? 0
        self.ownerId    = json["owner_id"].intValue
        self.userId     = json["user_id"].intValue

        let sizes = json["sizes"].compactMap( { Sizes(json: $0.1) } )
        self.sizes.append(objectsIn: sizes)

    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class Sizes: Object {
    
    @objc dynamic var typeDescription: String = ""
    @objc dynamic var urlString: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0

    var type: Types {
        return Types(rawValue: typeDescription) ?? .none
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    
    enum Types: String {
        case s, m, x, y, z, w, o, p, q, r
        case none
    }
    
    convenience init(json: JSON) {
        self.init()
        self.typeDescription = json["type"].stringValue
        self.urlString = json["url"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
        
    }
    
}
