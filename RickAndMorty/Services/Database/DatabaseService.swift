//
//  DatabaseService.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation
import RealmSwift

actor DatabaseActor<T: Object> {
    // An implicitly-unwrapped optional is used here to let us pass `self` to
    // `Realm(actor:)` within `init`
    var realm: Realm!
    
    init() async throws {
        realm = try await Realm(actor: self)
    }
    
    func createOrUpdate<T: Object>(_ item: T, update: Realm.UpdatePolicy = .all, updateProperties: (T) -> Void) async throws {

        try realm.write {
            updateProperties(item)
            realm.add(item, update: update)
        }
    }
    
    func readAll() throws -> Results<T> {
        return realm.objects(T.self)
    }
    
    func readAllCount() throws -> Int {
        return realm.objects(T.self).count
    }
}

