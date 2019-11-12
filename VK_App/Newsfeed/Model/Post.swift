//
//  Post.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Post {
    
    let type: Types
    let sourceId: Int
    let date: Date
    let text: String
    let attachments: [Photo]
    
    var likes: Likes
    var reposts: Reposts
    var comments: Comments
    
    enum Types: String {
        case post, link
        case wallPhoto = "wall_photo"
        case none
    }
    
    init?(json: JSON) {
        guard Post.Types(rawValue: json["type"].stringValue) ?? .none == .post else { return nil }

        self.type = Post.Types(rawValue: json["type"].stringValue) ?? .none
        self.sourceId = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: TimeInterval(json["date"].intValue))
        self.text = json["text"].stringValue
        
        self.likes = Likes(json: json["likes"])
        self.reposts = Reposts(json: json["reposts"])
        self.comments = Comments(json: json["comments"])
        
        switch self.type {
        case .post:
            self.attachments = json["attachments"].compactMap { result in
                return result.1["type"] == "photo" ? Photo(json: result.1["photo"]) : nil
            }
        case .wallPhoto:
            self.attachments = json["photos"]["items"].compactMap { result in
                let json = result.1
                return Photo(json: json)
            }
        default:
            self.attachments = [Photo]()
        }
        
        if self.attachments.count == 0 {
            return nil
        }
        
    }
    
}

extension Post {
    
    struct Likes {
        
        let count: Int
        let isLiked: Bool
        let canLike: Bool?
        let canPublish: Bool?
        
        init(json: JSON) {
            self.count = json["count"].intValue
            self.isLiked = json["user_likes"].boolValue
            self.canLike = json["can_like"].bool
            self.canPublish = json["can_publish"].bool
        }
        
    }
    
    struct Reposts {
        
        let count: Int
        let isReposted: Bool?
        
        init(json: JSON) {
            self.count = json["count"].intValue
            self.isReposted = json["user_reposted"].bool
        }
        
    }
    
    struct Comments {
        
        let count: Int
        let canPost: Bool?
        
        init(json: JSON) {
            self.count = json["count"].intValue
            self.canPost = json["can_post"].bool
        }
        
    }
    
}
