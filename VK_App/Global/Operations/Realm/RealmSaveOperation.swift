//
//  RealmSaveOperation.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSaveOperation: RealmOperation {
    
    override var isAsynchronous: Bool {
        return true
    }
    
    let update: Realm.UpdatePolicy

    init(_ entity: Object, update: Realm.UpdatePolicy = .error) {
        self.update = update
        super.init(entity)
    }
    
    init(_ entities: [Object], update: Realm.UpdatePolicy = .error) {
        self.update = update
        super.init(entities)
    }
    
    override func main() {
        autoreleasepool {
            self.write()
        }
    }
    
    func write() {
        do {
            let realm = try Realm()
            try realm.write {
                if let entity = self.entity {
                    realm.add(entity, update: update)
                } else if let entities = self.entities {
                    realm.add(entities, update: update)
                }
            }
        } catch let error {
            print(error)
            print(error.localizedDescription)
        }
    }
    
}
