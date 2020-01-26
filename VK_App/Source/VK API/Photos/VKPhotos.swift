//
//  VKPhotos.swift
//  VK_App
//
//  Created by Maxim Baranets on 05.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import Alamofire

class VKPhotos: VKConfiguration {
    
    /// Return list of the photos specified user (if the owner_id == nil then return the list of the photos of the logined user)
    func get(ownerId: Int?, completion: @escaping (VKPhotoGetResponse) -> Void) {
        
        // Create a URL request
        var urlComponents = self.urlComponents
       
        urlComponents.path   = "/method/photos.get"
        
        var stringOwnerId: String?
        if let ownerId = ownerId {
            stringOwnerId = String(ownerId)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: stringOwnerId ?? ""),
            URLQueryItem(name: "album_id", value: "wall")
        ] + defaultQueryItems
        
       //Treatment of the JSON
        Alamofire.request(urlComponents.url!).responseData(queue: dispatchQueue) { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(VKPhotoGetResponse.self, from: data)
                    completion(response)
                } catch (let error) {
                    print(error)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
       }
    }
    
}
