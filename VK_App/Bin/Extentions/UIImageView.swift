import Foundation
import UIKit

extension UIImageView {
    
    ///[EN]Download Photo from URL and optionally add it to the Cache /[RU]Загружает Фото по указанному URL и опционально добавляет его в в Кэш
    func downloadPhoto(fromURL: URL?, imageCache: NSCache<AnyObject, AnyObject>?) {
        DispatchQueue.global().async {
            if imageCache != nil {
                if let imageFromCache = imageCache?.object(forKey: fromURL as AnyObject) as? UIImage {
                    DispatchQueue.main.async {
                        self.image = imageFromCache
                    }
                    return
                }
            }
            URLSession.shared.dataTask(with: fromURL!) { data, response, error in
                guard error == nil, (response as? HTTPURLResponse)?.statusCode == 200, let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data) ?? UIImage()
                    self.image = image
                    if imageCache != nil {
                         imageCache?.setObject(image, forKey: fromURL as AnyObject)
                    }
                }
            }.resume()
        }
    }
}
