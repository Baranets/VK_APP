//
//  RealmOperation.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import RealmSwift

class RealmOperation: Operation {
    
    override var isAsynchronous: Bool {
        return false
    }

    internal let entity: Object?
    internal let entities: [Object]?
    internal let entityList: List<Object>?
    internal let entityResults: Results<Object>?
    
    internal init(_ entity: Object) {
        self.entity = entity
        self.entities = nil
        self.entityList = nil
        self.entityResults = nil
    }
    
    internal init(_ entities: [Object]) {
        self.entity = nil
        self.entities = entities
        self.entityList = nil
        self.entityResults = nil
    }
    
    internal init(_ entities: List<Object>) {
        self.entity = nil
        self.entities = nil
        self.entityList = entities
        self.entityResults = nil
    }
    
    internal init(_ entities: Results<Object>) {
        self.entity = nil
        self.entities = nil
        self.entityList = nil
        self.entityResults = entities
    }
}
