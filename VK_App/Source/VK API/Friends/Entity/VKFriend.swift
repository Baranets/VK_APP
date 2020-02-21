//
//  VKFriend.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - VKFriend
class VKFriend: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var domain: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var trackCode: String = ""
    @objc dynamic var isClosed: Bool = false
    @objc dynamic var canAccessClosed: Bool = false
    @objc dynamic var city: VKCity?
    @objc dynamic var online: Int = 0
    
    var isOnline: Bool {
        return online == 1
    }
    
    var fullSurname: String {
        return lastName + " " + firstName
    }
    
    var photoURL: URL? {
        return URL(string: photo)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["id", "lastName"]
    }

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case trackCode = "track_code"
        case domain, city, online, photo
    }
}
