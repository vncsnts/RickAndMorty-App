//
//  DatabaseService.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation
import RealmSwift

final class DatabaseService {
    static let shared = DatabaseService()
    
    @MainActor
    func storeCharacter(_ character: Character) async {
        do {
            let realm = try await Realm()
            let existingCharacter = realm.object(ofType: Character.self, forPrimaryKey: character.id)
            if existingCharacter == nil {
                try realm.write {
                    realm.add(character)
                }
            }
        } catch (let error) {
            print("An error occurred while storing the character: \(error)")
        }
    }
    
    @MainActor
    func updateCharacter(_ character: Character) async {
        do {
            let realm = try await Realm()
            if let existingCharacter = realm.object(ofType: Character.self, forPrimaryKey: character.id) {
                try realm.write {
                    existingCharacter.isFavorite.toggle()
                }
            }
        } catch (let error) {
            print("An error occurred while storing the character: \(error)")
        }
    }
    
    @MainActor
    func getAllCharacters() async -> Result<Results<Character>, Error> {
        do {
            let realm = try await Realm()
            return .success(realm.objects(Character.self))
        } catch (let error) {
            print("An error occurred while storing the character: \(error)")
            return .failure(error)
        }
    }
}
