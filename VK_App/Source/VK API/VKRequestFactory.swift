//
//  VKRequestFactory.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

class VKRequestFactory {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func loadFriendList(by userId: Int?) {
        VKFriends().get(by: userId) { (response) in
            let opQueue = OperationQueue()
            let op = RealmSaveOperation(response.response.items, update: .all)
            opQueue.addOperation(op)
        }
    }
    
    func loadGroupList(by userId: Int?) {
        VKGroupRequest().get(by: userId) { (response) in
            let opQueue = OperationQueue()
            let op = RealmSaveOperation(response.response.items, update: .all)
            opQueue.addOperation(op)
        }
    }
    
}
