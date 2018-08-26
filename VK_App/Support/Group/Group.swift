
import Foundation
import UIKit

class Group: GroupProtocol {
    
    var name: String
    var image: UIImage
    var countSubscribers: Int
    
    func downloadNews() {
        //write your code
    }
    
    init() {
        self.name = "noNameGroup"
        self.image = UIImage(named: "people")!
        self.countSubscribers = 0
    }
    
    init(name: String, countSubscribers: Int) {
        self.name = name
        self.image = UIImage(named: "people")!
        self.countSubscribers = countSubscribers
    }
    
    init(name: String, image: UIImage, countSubscribers: Int) {
        self.name = name
        self.image = image
        self.countSubscribers = countSubscribers
    }
    
}
