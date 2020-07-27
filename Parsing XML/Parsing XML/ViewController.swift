//
//  ViewController.swift
//  Parsing XML
//
//  Created by Gilang Ramadhan on 27/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let poster: String
}

class ViewController: UIViewController {
    var movieTitle = String()
    var overview = String()
    var poster = String()
    var elementName = String()
    var id = 0
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = Bundle.main.url(forResource: "Movies", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
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

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "movie" {
            let movie = Movie(id: id, title: movieTitle, overview: overview, poster: poster)

            movies.append(movie)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
        movies.forEach { movie in
            print("ID: \(movie.id)")
            print("TITLE: \(movie.title)")
            print("OVERVIEW: \(movie.overview)")
            print("POSTER: \(movie.poster)")
        }
    }
}
