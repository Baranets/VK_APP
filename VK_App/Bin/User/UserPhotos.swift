import Foundation
import UIKit
import SwiftyJSON

///Class is for storage data about photo
class UserPhoto {
    
    var id:    Int
    var url:   URL
    
    init(json: JSON) {
        self.id   = json["id"].intValue
        self.url  = URL(string: json["sizes"][0]["url"].stringValue)!
    }
    
}
