//
//  ImageDownloader.swift
//  VK_App
//
//  Created by Maxim Baranets on 05.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    let cache = AutoPurgingImageCache(
        memoryCapacity: 256 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 128 * 1024 * 1024
    )
    
    func downloadImage(fromURL: URL, imageCache: AutoPurgingImageCache?, completion: @escaping (UIImage?) -> ()) {
        let key = fromURL
        DispatchQueue.global().async {
            guard let cache = imageCache == nil ? self.cache : imageCache else { return }
            let urlRequest = URLRequest(url: fromURL)

            if let imageFromCache = cache.image(for: urlRequest) {
                completion(key == fromURL ? imageFromCache : nil)
                return
            }
            Alamofire.request(fromURL).responseImage { (response) in
                switch response.result {
                case .success(let image):
                    cache.add(image, for: urlRequest)
                    completion(key == fromURL ? image : nil)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
    }
}
