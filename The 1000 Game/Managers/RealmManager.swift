//
//  RealmManager.swift
//  The 1000 Game
//
//  Created by Sanchez on 20.11.2023.
//

import Foundation
import RealmSwift

final class RealmManager<T: Object> {
    private let realm = try? Realm()
    
    func read() -> [T] {
        guard let realm else { return []}
        return Array(realm.objects(T.self))
    }
    
    func write(_ object: T) {
        try? realm?.write({
            realm?.add(object)
        })
    }
    
    func update(realmBlock: ((Realm) -> Void)?) {
        guard let realm else { return }
        realmBlock?(realm)
    }
    
    func delete(object: T) {
        try? realm?.write({
            realm?.delete(object)
        })
    }
    
    func deleteAll(objects: [T]) {
        try? realm?.write({
            objects.forEach { object in
                realm?.delete(object)
            }
        })
    }
    
}
