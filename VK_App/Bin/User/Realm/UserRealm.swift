import Foundation
import RealmSwift
import SwiftyJSON

class RealmUser: Object {

    //MARK: - Variables

    @objc dynamic var id:             Int    = 0
    @objc dynamic var lastName:       String = ""
    @objc dynamic var name:           String = ""
    @objc dynamic var photoStringURL: String = ""
    @objc dynamic var isOnline:       Bool   = false

}
