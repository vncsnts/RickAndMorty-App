//
//  LoadingView.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import SwiftUI

struct LoadingView: View {
    @Binding var message: String
    var body: some View {
        VStack {
            VStack {
                Text(message)
                    .multilineTextAlignment(.center)
                ProgressView()
            }
            .padding()
        }
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .contentShape(Rectangle())
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(message: .constant("Loading..."))
    }
}
