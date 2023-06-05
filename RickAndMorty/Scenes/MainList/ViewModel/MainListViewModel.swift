//
//  MainListViewModel.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation
import RealmSwift

@MainActor
final class MainListViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var isLoading = false
    @Published var loadingMessage = ""
    @Published var isCharacterPresent = false
    @Published var currentCharacter: Character?
    private let apiService = APIService()
    private var charactersDb: DatabaseActor<Character>!
    
    init() {
        Task {
            do {
                self.charactersDb = try await DatabaseActor<Character>()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getCharacters() {
        Task {
            isLoading = true
            loadingMessage = "Loading Characters..."
            let getCharactersResponse = await apiService.getAllCharacters()
            switch getCharactersResponse {
            case .success(let characters):
                for character in characters {
                    if let localCharacter = try await Array(self.charactersDb.readAll()).first(where: {$0.id == character.id}), localCharacter.isFavorite {
                        try await self.charactersDb.createOrUpdate(character, updateProperties: { toBeSavedCharacter in
                            toBeSavedCharacter.isFavorite = true
                        })
                    } else {
                        try await self.charactersDb.createOrUpdate(character, updateProperties: { _ in })
                    }
                }
                self.characters = try await Array(self.charactersDb.readAll())
            case .failure(_):
                self.characters = try await Array(self.charactersDb.readAll())
            }
            isLoading = false
        }
    }
    
    func toggleFavoriteForCharacter(character: Character) {
        Task {
            try await charactersDb.createOrUpdate(character, updateProperties: { test in
                character.isFavorite.toggle()
            })
            
            guard let firstIndexForCharacter = characters.firstIndex(of: character) else { return }
            characters[firstIndexForCharacter] = character
        }
    }
}

enum MainListState {
    case loading
    case stable
}
