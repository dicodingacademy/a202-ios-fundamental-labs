//
//  ContentView.swift
//  GreetingApps
//
//  Created by Gilang Ramadhan on 02/09/22.
//

import SwiftUI

struct ContentView: View {
  @State var showingAlert = false

  var body: some View {
    Button(action: {self.showingAlert = true }) {

      Text("Halo")
        .font(.title)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .padding(.all)
        .frame(width: nil)
    }.alert(isPresented: $showingAlert) {
      Alert(
        title: Text("Apa kabar?"),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
