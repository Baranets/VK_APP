//
//  VKGroupGetResponse.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation

struct VKGroupGetResponse: Codable {
    let response: Response
    
    // MARK: - Response
    struct Response: Codable {
        let count: Int
        let items: [VKGroup]
    }
    
}
