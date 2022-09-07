//
//  NetworkService.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 29/08/22.
//

import Foundation

class NetworkService {

  // MARK: Gunakan API Key dalam akun Anda.
  let apiKey = "API_KEY"
  let language = "en-US"
  let page = "1"

  func getMovies() async throws -> [Movie] {
    var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
    components.queryItems = [
      URLQueryItem(name: "api_key", value: apiKey),
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "page", value: page)
    ]
    let request = URLRequest(url: components.url!)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error: Can't fetching data.")
    }

    let decoder = JSONDecoder()
    let result = try decoder.decode(MovieResponses.self, from: data)

    return movieMapper(input: result.movies)
  }
}

//  MARK: Digunakan untuk Completion Handler
//class NetworkService {
//  // MARK: Gunakan API Key dalam akun Anda.
//  let apiKey = "API_KEY"
//  let language = "en-US"
//  let page = "1"
//
//  func getMovies(
//    completion: @escaping ([Movie]) -> Void
//  ) {
//    var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
//    components.queryItems = [
//      URLQueryItem(name: "api_key", value: apiKey),
//      URLQueryItem(name: "language", value: language),
//      URLQueryItem(name: "page", value: page)
//    ]
//    let request = URLRequest(url: components.url!)
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//      guard let response = response as? HTTPURLResponse else { return }
//
//      if let data = data {
//        if response.statusCode == 200 {
//          let decoder = JSONDecoder()
//          do {
//            let result = try decoder.decode(MovieResponses.self, from: data)
//            completion(self.movieMapper(input: result.movies))
//          } catch {
//            print("Error: Can't decode JSON.")
//          }
//
//        } else {
//          print("ERROR: \(data), HTTP Status: \(response.statusCode)")
//        }
//      }
//    }
//    task.resume()
//  }
//}

extension NetworkService {
  fileprivate func movieMapper(
    input movieResponses: [MovieResponse]
  ) -> [Movie] {
    return movieResponses.map { result in
      return Movie(
        title: result.title,
        popularity: result.popularity,
        genres: result.genres,
        voteAverage: result.voteAverage,
        overview: result.overview,
        releaseDate: result.releaseDate,
        posterPath: result.posterPath
      )
    }
  }
}
