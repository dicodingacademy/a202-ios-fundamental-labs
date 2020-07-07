//
//  ContentView.swift
//  UITesting
//
//  Created by Gilang Ramadhan on 28/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showingAlert = false
    
    var body: some View {
        Button(action: { self.showingAlert = true }) {
            Text("Halo")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.all)
                .frame(width: nil)
        }
//        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Apa kabar?"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
