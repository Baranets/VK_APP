//
//  VKPhotoGetResponse.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

// MARK: - VKPhotoGet
struct VKPhotoGetResponse: Codable {
    let response: Response
    
    // MARK: - Response
    struct Response: Codable {
        let count: Int
        let items: [VKPhoto]
    }
}



// MARK: - Item
struct VKPhoto: Codable {
    let id: Int
    let albumId, ownerId, userId: Int?
    let sizes: [Size]
    let text: String
    let date: Int
    let postId: Int?
    let accessKey: String?

    // MARK: - Size
    struct Size: Codable {
        let type: String
        let url: String
        let width, height: Int
        
        var photoURL: URL? {
            return URL(string: url)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case userId = "user_id"
        case sizes, text, date
        case postId = "post_id"
        case accessKey = "access_key"
    }
}


