import Foundation
import RealmSwift

class GroupRealm: Object {
    
    //MARK: - Variables
    
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photoStringURL: String = ""
    @objc dynamic var largePhotoStringURL: String = ""
    @objc dynamic var countSubscribers: Int = 0
}
