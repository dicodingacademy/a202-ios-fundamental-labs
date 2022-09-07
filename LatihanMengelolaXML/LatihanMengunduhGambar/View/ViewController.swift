//
//  ViewController.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 04/08/22.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var movieTableView: UITableView!
  var movieTitle = String()
  var overview = String()
  var poster = String()
  var elementName = String()
  var id = 0
  var movies = [Movie]()

  override func viewDidLoad() {
    super.viewDidLoad()
    movieTableView.dataSource = self

    movieTableView.register(
      UINib(nibName: "MovieTableViewCell", bundle: nil),
      forCellReuseIdentifier: "movieTableViewCell"
    )

    if let path = Bundle.main.url(forResource: "Movies", withExtension: "xml") {
      if let parser = XMLParser(contentsOf: path) {
        parser.delegate = self
        parser.parse()
      }
    }
  }
}

extension ViewController: UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return movies.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: "movieTableViewCell",
      for: indexPath
    ) as? MovieTableViewCell {
      
      let movie = movies[indexPath.row]
      cell.movieTitle.text = movie.title
      cell.movieImage.image = movie.image

      if movie.state == .new {
        cell.indicatorLoading.isHidden = false
        cell.indicatorLoading.startAnimating()
        startDownload(movie: movie, indexPath: indexPath)
      } else {
        cell.indicatorLoading.stopAnimating()
        cell.indicatorLoading.isHidden = true
      }

      return cell
    } else {
      return UITableViewCell()
    }
  }

  fileprivate func startDownload(movie: Movie, indexPath: IndexPath) {
    let imageDownloader = ImageDownloader()
    if movie.state == .new {
      Task {
        do {
          let image = try await imageDownloader.downloadImage(url: movie.poster)
          movie.state = .downloaded
          movie.image = image
          self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
        } catch {
          movie.state = .failed
          movie.image = nil
        }
      }
    }
  }

}

extension ViewController: XMLParserDelegate {
  func parser(
    _ parser: XMLParser,
    didStartElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?,
    attributes attributeDict: [String: String] = [:]
  ) {
    if elementName == "movie" {
      movieTitle = String()
      overview = String()
      poster = String()

      if let id = attributeDict["id"], let intId = Int(id) {
        self.id = intId
      }
    }

    self.elementName = elementName
  }

  func parser(
    _ parser: XMLParser,
    didEndElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?
  ) {
    if elementName == "movie" {

      let posterPath = URL(string: "https://image.tmdb.org/t/p/w300\(poster)")!
      let movie = Movie(id: id, title: movieTitle, overview: overview, poster: posterPath)
      movies.append(movie)
    }
  }

  func parser(
    _ parser: XMLParser,
    foundCharacters string: String
  ) {
    let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

    if !data.isEmpty {
      switch elementName {
      case "title": movieTitle = data
      case "overview": overview = data
      case "poster": poster = data
      default: break
      }
    }
  }

  func parserDidEndDocument(_ parser: XMLParser) {
    movieTableView.reloadData()
  }
}
