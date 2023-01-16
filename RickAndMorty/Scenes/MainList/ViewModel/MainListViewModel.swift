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
    @ObservedResults(Character.self) var characters
    @Published var state = MainListState.stable
    @Published var customMessage = "Loading..."
    @Published var isCharacterPresent = false
    @Published var currentCharacter: Character?
    
    func getCharacters() {
        Task {
            customMessage = "Loading Characters..."
            state = .loading
            let getCharactersResponse = await APIService.shared.getAllCharacters()
            state = .stable
            switch getCharactersResponse {
            case .success(_):
                break
            case .failure(let customError):
                print(customError)
            }
        }
    }
    
    func toggleFavoriteForCharacter(character: Character) {
        Task {
            state = .loading
            await DatabaseService.shared.updateCharacter(character)
            state = .stable
        }
    }
}

enum MainListState {
    case loading
    case stable
}
