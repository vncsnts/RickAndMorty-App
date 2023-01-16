//
//  MainListView.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import SwiftUI

struct MainListView: View {
    @ObservedObject var viewModel = MainListViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .stable:
                List {
                    ForEach(viewModel.characters) { character in
                        MainListRowView(character: character) {
                            viewModel.toggleFavoriteForCharacter(character: character)
                        } didTapPresent: {
                            viewModel.currentCharacter = character
                            viewModel.isCharacterPresent = true
                        }
                    }
                }
                .animation(.easeIn, value: viewModel.state)
            case .loading:
                LoadingView(message: $viewModel.customMessage)
                    .animation(.easeIn, value: viewModel.state)
            }
        }
        .navigationTitle("Characters")
        .onAppear {
            viewModel.getCharacters()
        }
        .sheet(isPresented: $viewModel.isCharacterPresent) {
            CharacterView(character: viewModel.currentCharacter ?? Character())
                .onDisappear {
                    viewModel.currentCharacter = nil
                }
        }
        
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
