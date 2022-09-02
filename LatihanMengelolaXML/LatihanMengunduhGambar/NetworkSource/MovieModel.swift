//
//  MovieDetail.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 04/08/22.
//

import UIKit

enum DownloadState {
  case new, downloaded, failed
}

class Movie {
  let id: Int
  let overview: String

  let title: String
  let poster: URL

  var image: UIImage?
  var state: DownloadState = .new

  init(id: Int, title: String, overview: String, poster: URL) {
    self.id = id
    self.title = title
    self.overview = overview
    self.poster = poster
  }
}

