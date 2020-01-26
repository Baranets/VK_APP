//
//  VKNewsFeed.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class VKNewsFeed: VKConfiguration {
    
    func get(startFrom: String?, completion: @escaping (VKNewsFeedGetResponse) -> ()) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/method/newsfeed.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "count", value: "25"),
            URLQueryItem(name: "filters", value: "post")
        ] + defaultQueryItems
        
        if let startFrom = startFrom {
            urlComponents.queryItems?.append(URLQueryItem(name: "start_from", value: startFrom))
        }
        
        
        Alamofire.request(urlComponents.url!).responseData(queue: dispatchQueue) { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(VKNewsFeedGetResponse.self, from: data)
                    completion(response)
                    
                } catch {
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
