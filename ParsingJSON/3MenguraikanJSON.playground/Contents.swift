import UIKit

/*
 Gunakanlah API Key Anda!
 Silakan daftar di https://www.dicoding.com/blog/registrasi-testing-themoviedb-api/.
 */

let apiKey = "API KEY"
let language = "en-US"
let page = "1"

var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!

components.queryItems = [
    URLQueryItem(name: "api_key", value: apiKey),
    URLQueryItem(name: "language", value: language),
    URLQueryItem(name: "page", value: page)
]

let request = URLRequest(url: components.url!)

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let response = response as? HTTPURLResponse, let data = data else { return }
    
    if response.statusCode == 200 {
        decodeJSON(data: data)
    } else {
        print("ERROR: \(data), HTTP Status: \(response.statusCode)")
    }
}

task.resume()

struct Movies: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    let popularity: Double
    let posterPath: String
    let title: String
    let genres: [Int]
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case posterPath = "poster_path"
        case title
        case genres = "genre_ids"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

private func decodeJSON(data: Data) {
    let decoder = JSONDecoder()
    
    if let movies = try? decoder.decode(Movies.self, from: data) as Movies {
        print("PAGE: \(movies.page)")
        print("TOTAL RESULTS: \(movies.totalResults)")
        print("TOTAL PAGES: \(movies.totalPages)")

        movies.movies.forEach { movie in
            print("TITLE: \(movie.title)")
            print("POSTER: \(movie.posterPath)")
            print("DATE: \(movie.releaseDate)")
        }
    } else {
        print("ERROR: Can't Decode JSON")
    }
}
