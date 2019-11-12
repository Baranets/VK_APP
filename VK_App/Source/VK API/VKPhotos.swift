//
//  VKPhotos.swift
//  VK_App
//
//  Created by Maxim Baranets on 05.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKPhotos: VKConfiguration {
    
    ///Return list of the photos specified user (if the owner_id == nil then return the list of the photos of the logined user)
       func get(owner_id: String?, completion: @escaping ([Photo]) -> Void) {
           
           //Create a URL request
           var urlComponents = self.urlComponents
           
           urlComponents.path   = "/method/photos.get"
                   
           urlComponents.queryItems = [
               URLQueryItem(name: "owner_id", value: owner_id ?? ""),
               URLQueryItem(name: "album_id", value: "profile")
           ] + defaultQueryItems
           //Treatment of the JSON
           Alamofire.request(urlComponents.url!).responseData { response in
               guard let data = response.value else {
                   return
               }
               DispatchQueue.global().async {
                   do {
                       let json = try JSON(data: data)
                       let userPhotos = json["response"]["items"].compactMap { Photo(json: $0.1) }
                       completion(userPhotos)
                   } catch {
                       return
                   }
               }
           }
       }
    
}
