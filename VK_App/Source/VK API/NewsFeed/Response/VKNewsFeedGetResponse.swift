//
//  VKNewsFeedGetResponse.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

// MARK: - VKNewsFeedGetResponse
struct VKNewsFeedGetResponse: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let items: [VKPost]
    let profiles: [VKProfile]
    let groups: [VKGroup]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Item
struct VKPost: Codable {
    let canDoubtCategory, canSetCategory: Bool?
    let type: String
    let sourceId, date: Int
    let postType, text: String
    let markedAsAds: Int
    let attachments: [VKAttachment]?
    let postSource: VKPostSource
    let comments: VKComments
    let likes: VKLikes
    let reposts: VKReposts
    let views: VKViews?
    let isFavorite: Bool
    let postId: Int

    enum CodingKeys: String, CodingKey {
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case type
        case sourceId = "source_id"
        case date
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case postId = "post_id"
    }
}

// MARK: - Attachment
struct VKAttachment: Codable {
    
    let type: String
    private let photo: VKPhoto?
    private let audio: VKAudio?
    
    var media: Codable? {
        switch type {
        case "photo":
            return photo
        case "audio":
            return audio
        default:
            return nil
        }
    }
    
    enum MediaType: String, Codable {
        case photo, audio, video
        
    }
}

// MARK: - Audio
struct VKAudio: Codable {
    let artist: String?
    let id, ownerId: Int?
    let title: String?
    let duration: Int?
    let trackCode: String?
    let url: String?
    let date, albumId: Int?
    let mainArtists: [MainArtist]?

    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerId = "owner_id"
        case title, duration
        case trackCode = "track_code"
        case url, date
        case albumId = "album_id"
        case mainArtists = "main_artists"
    }
}

// MARK: - MainArtist
struct MainArtist: Codable {
    let name, domain, id: String?
}

// MARK: - Comments
struct VKComments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Likes
struct VKLikes: Codable {
    let count, userLikes, canLike, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct VKPostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct VKReposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct VKViews: Codable {
    let count: Int
}

// MARK: - Profile
struct VKProfile: Codable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool?
    let sex: Int
    let screenName: String?
    let photo50, photo100: String
    let online, onlineMobile: Int?
    let onlineInfo: VKOnlineInfo

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case onlineMobile = "online_mobile"
        case onlineInfo = "online_info"
    }
}

// MARK: - OnlineInfo
struct VKOnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
