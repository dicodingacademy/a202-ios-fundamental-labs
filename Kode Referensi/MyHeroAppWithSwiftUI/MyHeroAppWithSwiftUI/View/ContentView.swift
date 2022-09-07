//
//  ContentView.swift
//  MyHeroAppWithSwiftUI
//
//  Created by Gilang Ramadhan on 05/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HeroList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
