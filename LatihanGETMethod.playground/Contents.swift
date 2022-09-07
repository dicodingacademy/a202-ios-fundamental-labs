import Cocoa

// MARK: Gunakan API Key dalam akun Anda.
let apiKey = "API_KEY"
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
  guard let response = response as? HTTPURLResponse else { return }

  if let data = data {
    if response.statusCode == 200 {
      decodeJSON(from: data)
    } else {
      print("ERROR: \(data), HTTP Status: \(response.statusCode)")
    }
  }
}

task.resume()

func decodeJSON(from data: Data) {
  let decoder = JSONDecoder()

  if let movies = try? decoder.decode(MovieResponses.self, from: data) as MovieResponses {
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

struct MovieResponses: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let movies: [MovieResponse]

  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movies = "results"
  }
}

struct MovieResponse: Codable {
  let popularity: Double
  let posterPath: String
  let title: String
  let genres: [Int]
  let voteAverage: Double
  let overview: String
  let releaseDate: Date

  enum CodingKeys: String, CodingKey {
    case popularity
    case posterPath = "poster_path"
    case title
    case genres = "genre_ids"
    case voteAverage = "vote_average"
    case overview
    case releaseDate = "release_date"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // Menentukan alamat gambar
    let path = try container.decode(String.self, forKey: .posterPath)
    posterPath = "https://image.tmdb.org/t/p/w300\(path)"

    // Mementukan tanggal rilis
    let dateString = try container.decode(String.self, forKey: .releaseDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    releaseDate = dateFormatter.date(from: dateString)!

    // Untuk properti lainnya, cukup disesuaikan saja.
    popularity = try container.decode(Double.self, forKey: .popularity)
    title = try container.decode(String.self, forKey: .title)
    genres = try container.decode([Int].self, forKey: .genres)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    overview = try container.decode(String.self, forKey: .overview)
  }
}
