import Foundation
import UIKit
import SwiftyJSON

class Group: Entity {

    //MARK: - Variables
    
    var name: String
    var photo: UIImage?
    
    ///[EN]Identification number of the Group /[RU]Идентификационный номер группы
    var id: Int
    ///[EN] URL of the group image /[RU] URL фотографии группы
    var photoURL: URL?
    ///[EN] URL of the group image(large) /[RU] URL фотографии(большой) группы
    var largePhotoURL: URL?
    ///[EN] Large Photo (UIImage) of the Group /[RU] Большая Фотография (UIImage) Группы
    var largePhoto: UIImage?
    var countSubscribers: Int?
    
    //MARK: - Inits
    
    init() {
        self.id = 0
        self.name = "noNameGroup"
        self.photo = UIImage(named: "people")!
        self.countSubscribers = 0
    }
    
    init(id: Int, name: String, countSubscribers: Int) {
        self.id = id
        self.name = name
        self.photo = UIImage(named: "people")!
        self.countSubscribers = countSubscribers
    }
    
    init(id: Int, name: String, image: UIImage, countSubscribers: Int) {
        self.id = 0
        self.name = name
        self.photo = image
        self.countSubscribers = countSubscribers
    }
    
    init(json: JSON) {
        self.id            = json["id"].intValue
        self.name          = json["name"].stringValue
        self.photoURL      = URL(string: json["photo_50"].stringValue)
        self.largePhotoURL = URL(string: json["photo_200"].stringValue)
    }
    
}
