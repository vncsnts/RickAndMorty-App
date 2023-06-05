//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterView: View {
    @State var character: Character
    
    var body: some View {
        ZStack {
            VStack {
                AnimatedImage(url: URL(string: character.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .blur(radius: 100)
            VStack(alignment: .leading) {
                VStack {
                    AnimatedImage(url: URL(string: character.image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .clipShape(Rectangle())
                .cornerRadius(15)
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Name: \(character.name)")
                        .font(.headline)
                    Text("Status: \(character.status)")
                        .font(.headline)
                    Text("Gender: \(character.gender)")
                        .font(.headline)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character())
    }
}
