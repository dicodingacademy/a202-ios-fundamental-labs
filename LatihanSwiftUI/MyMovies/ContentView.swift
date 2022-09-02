//
//  ContentView.swift
//  MyMovies
//
//  Created by Gilang Ramadhan on 30/08/22.
//

import SwiftUI

struct ContentView: View {

  @State var myMovies: [Movie] = []
  @State var isLoading = true
  @State var isError = false

  var body: some View {
    VStack {
      if isLoading {
        ProgressView()
        Text("Sedang memuat data...")
          .padding()
      } else {
        List {
          ForEach(myMovies) { movie in
            MovieItemView(movie: movie)
          }
        }
      }
    }.task {
      let networkService = NetworkService()
      isLoading = true
      do {
        self.myMovies = try await networkService.getMovies()
        isLoading = false
        isError = false
      } catch {
        isLoading = false
        isError = true
      }
    }.alert("Gagal memuat data!", isPresented: $isError) {
      Button("OK", role: .cancel) {}
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
