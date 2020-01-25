//
//  VKNewsFeed.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

class VKNewsFeed: VKConfiguration {
    
    func get(startFrom: String?, completion: @escaping ([Post]?, [Group]?) -> ()) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/method/newsfeed.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "count", value: "25"),
        ] + defaultQueryItems
        
        if let startFrom = startFrom {
            urlComponents.queryItems?.append(URLQueryItem(name: "start_from", value: startFrom))
        }
        
        
        Alamofire.request(urlComponents.url!).responseData(queue: dispatchQueue) { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let dispatchGroup = DispatchGroup()
                    
                    var posts: [Post]?
                    var profiles: [Group]?
                    
                    dispatchGroup.enter()
                    DispatchQueue.global().async {
                        posts = json["response"]["items"].compactMap( { Post(json: $0.1) } )
                        dispatchGroup.leave()
                    }
                    
                    dispatchGroup.enter()
                    DispatchQueue.global().async {
                        profiles = json["response"]["groups"].compactMap( { Group(json: $0.1) } )
                        dispatchGroup.leave()
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        completion(posts, profiles)
                    }
                    
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
