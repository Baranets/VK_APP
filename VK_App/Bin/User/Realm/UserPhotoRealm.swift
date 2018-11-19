import Foundation
import RealmSwift

class UserPhotoRealm: Object {
    //MARK: - Variables
    
    ///[EN]Identification number of the Photo /[RU]Идентификационный номер фотографии
    @objc dynamic var id:          Int    = 0
    ///[EN]URL of the Photo /[RU]URL Фотографии
    @objc dynamic var stringURL:   String = ""
}
