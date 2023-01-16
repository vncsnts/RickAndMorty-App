//
//  MainListRowView.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainListRowView: View {
    @State var character: Character
    private let minimumContentDimension = 25.0
    private let maximumContentDimension = 50.0
    
    let didTapFavorites: (() -> Void)
    let didTapPresent: (() -> Void)

    var body: some View {
        HStack {
            Image(systemName: character.isFavorite ? "star.fill" : "star")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: minimumContentDimension, height: minimumContentDimension)
                .onTapGesture {
                    didTapFavorites()
                }
            AnimatedImage(url: URL(string: character.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: minimumContentDimension, maxWidth: maximumContentDimension, minHeight: minimumContentDimension, maxHeight: maximumContentDimension)
            Text(character.name)
                .font(.headline)
            Spacer()
            Image(systemName: "info.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: minimumContentDimension, height: minimumContentDimension)
                .onTapGesture {
                    didTapPresent()
                }
        }
    }
}
