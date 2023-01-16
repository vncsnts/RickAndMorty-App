//
//  DatabaseService.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation
import RealmSwift

actor DatabaseService {
    static let shared = DatabaseService()
    @ObservedResults(Character.self) var characters
    
    @MainActor
    func storeCharacter(_ character: Character) async {
        if !characters.contains(where: {$0.id == character.id}) {
            $characters.append(character)
        }
    }
    
    @MainActor
    func updateCharacter(_ character: Character) async {
        character.isFavorite.toggle()
    }
    
    func getAllCharacters() async throws -> Results<Character> {
        return await characters
    }
}
