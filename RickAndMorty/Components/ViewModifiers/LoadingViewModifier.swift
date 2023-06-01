//
//  LoadingView.swift
//  wave2
//
//  Created by Vince Carlo Santos on 8/10/22.
//  Copyright © 2022 Simply RFiD. All rights reserved.
//

import SwiftUI

struct LoadingView: ViewModifier {
    @Binding var isLoading: Bool
    @Binding var message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                loader()
            }
        }
    }
    
    @ViewBuilder private func loader() -> some View {
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

extension View {
    func loadingView(isLoading: Binding<Bool>, message: Binding<String> = .constant("Loading")) -> some View {
        self.modifier(LoadingView(isLoading: isLoading, message: message))
    }
}
