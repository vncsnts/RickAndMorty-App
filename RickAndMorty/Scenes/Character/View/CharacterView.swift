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
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(character.name)
                        .font(.largeTitle).bold()
                    Spacer()
                }
            }
            VStack {
                AnimatedImage(url: URL(string: character.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(Rectangle())
            .cornerRadius(15)
            .shadow(color: .blue, radius: 15)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Status: \(character.status)")
                    .font(.headline)
                Text("Gender: \(character.gender)")
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character())
    }
}
