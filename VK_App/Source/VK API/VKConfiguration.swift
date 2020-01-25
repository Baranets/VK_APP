//
//  VKConfiguration.swift
//  VK_App
//
//  Created by Maxim Baranets on 05.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

protocol VKConfiguration {
    
    var urlComponents: URLComponents { get }
    var scheme: String { get }
    var host: String { get }
    var defaultQueryItems: [URLQueryItem] { get }
    var dispatchQueue: DispatchQueue { get }
    var apiVersion: String { get }
        
}

extension VKConfiguration {
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host   = host
                
        return urlComponents
    }
    
    var defaultQueryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "access_token", value: VKAuth.token),
            URLQueryItem(name: "v", value: apiVersion)
        ]
    }
    
    var dispatchQueue: DispatchQueue {
        return .global(qos: .utility)
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.vk.com"
    }
    
    var apiVersion: String {
        return "5.103"
    }
    
}
