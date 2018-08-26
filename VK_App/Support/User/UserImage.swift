
import Foundation
import UIKit

class UserImage: UserImageProtocol {
    
    //MARK: - Variables
    var user: UserProtocol
    var images: [UIImage]
   
    //MARK: - Functions
    func downloadImages() {
        //Add your code in future for downloading
    }

    //MARK: - Inits
    init(user: UserProtocol, images: [UIImage]) {
        self.user = user
        self.images = images
    }
    
    init(user: UserProtocol) {
        self.user = user
        self.images = []
    }
    
}
