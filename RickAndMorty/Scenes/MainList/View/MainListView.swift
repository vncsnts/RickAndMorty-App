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
        List {
            ForEach(viewModel.characters) { character in
                MainListRowView(character: character) {
                    viewModel.toggleFavoriteForCharacter(character: character)
                } didTapPresent: {
                    viewModel.currentCharacter = character
                    viewModel.isCharacterPresent = true
                }
                .padding(.horizontal)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Characters")
        .loadingView(isLoading: $viewModel.isLoading, message: $viewModel.loadingMessage)
        .onAppear {
            viewModel.getCharacters()
        }
        .sheet(isPresented: $viewModel.isCharacterPresent) {
            CharacterView(character: viewModel.currentCharacter ?? Character())
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
