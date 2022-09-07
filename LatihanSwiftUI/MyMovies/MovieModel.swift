//
//  MovieModel.swift
//  MyMovies
//
//  Created by Gilang Ramadhan on 30/08/22.
//

import Foundation

class Movie: Identifiable {
  let idMovie: Int
  let title: String
  let overview: String
  let posterPath: URL

  init(idMovie: Int, title: String, overview: String, posterPath: URL) {
    self.idMovie = idMovie
    self.title = title
    self.posterPath = posterPath
    self.overview = overview
  }
}

let movies = [
  Movie(
    idMovie: 0,
    title: "Thor: Love and Thunder",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")!
  ), Movie(
    idMovie: 1,
    title: "Minions: The Rise of Gru",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg")!
  ), Movie(
    idMovie: 2,
    title: "Jurassic World Dominion",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")!
  ), Movie(
    idMovie: 3,
    title: "Top Gun: Maverick",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg")!
  ), Movie(
    idMovie: 4,
    title: "The Gray Man",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/8cXbitsS6dWQ5gfMTZdorpAAzEH.jpg")!
  ), Movie(
    idMovie: 5,
    title: "The Black Phone",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/p9ZUzCyy9wRTDuuQexkQ78R2BgF.jpg")!
  ), Movie(
    idMovie: 6,
    title: "Lightyear",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/ox4goZd956BxqJH6iLwhWPL9ct4.jpg")!
  ), Movie(
    idMovie: 7,
    title: "Doctor Strange in the Multiverse of Madness",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")!
  ), Movie(
    idMovie: 8,
    title: "Indemnity",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/tVbO8EAbegVtVkrl8wNhzoxS84N.jpg")!
  ), Movie(
    idMovie: 9,
    title: "Borrego",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/kPzQtr5LTheO0mBodIeAXHgthYX.jpg")!
  )
]

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
  let idMovie: Int
  let popularity: Double
  let title: String
  let genres: [Int]
  let voteAverage: Double
  let overview: String
  let releaseDate: Date

  let posterPath: URL

  enum CodingKeys: String, CodingKey {
    case idMovie = "id"
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
    posterPath = URL(string: "https://image.tmdb.org/t/p/w300\(path)")!

    // Mementukan tanggal rilis
    let dateString = try container.decode(String.self, forKey: .releaseDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    releaseDate = dateFormatter.date(from: dateString)!

    // Untuk properti lainnya, cukup disesuaikan saja.
    idMovie = try container.decode(Int.self, forKey: .idMovie)
    popularity = try container.decode(Double.self, forKey: .popularity)
    title = try container.decode(String.self, forKey: .title)
    genres = try container.decode([Int].self, forKey: .genres)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    overview = try container.decode(String.self, forKey: .overview)
  }
}
