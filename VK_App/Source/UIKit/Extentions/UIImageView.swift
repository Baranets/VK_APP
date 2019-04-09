import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    ///[EN]Download Photo from URL and optionally add it to the Cache /[RU]Загружает Фото по указанному URL и опционально добавляет его в в Кэш
    func downloadImage(fromURL: URL, imageCache: AutoPurgingImageCache?) {
        let key = fromURL
        
        let urlRequest = URLRequest(url: fromURL)
        
        if let imageFromCache = imageCache?.image(for: urlRequest) {
            self.image = key == fromURL ? imageFromCache : nil
            return
        }
        
        Alamofire.request(fromURL).responseImage { (response) in
            switch response.result {
            case .success(let image):
                self.image = key == fromURL ? image : nil
                imageCache?.add(image, for: urlRequest)
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}
