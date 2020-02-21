//
//  VKGroup.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Group
class VKGroup: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var type: String = ""
    
    @objc dynamic var isAdmin: Int      = 0
    @objc dynamic var isMember: Int     = 0
    @objc dynamic var isAdvertiser: Int = 0
    
    @objc dynamic var photo50: String  = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["name"]
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
