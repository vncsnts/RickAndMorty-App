//
//  BaseView.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import SwiftUI

struct BaseView: View {
    @State var mainListView = MainListView()
    
    var body: some View {
        NavigationView {
            mainListView
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
