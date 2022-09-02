//
//  ImageDownloader.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 05/08/22.
//

import UIKit

class ImageDownloader: Operation {
  private let movie: Movie

  init(movie: Movie) {
    self.movie = movie
  }

  override func main() {
    if isCancelled {
      return
    }

    guard let imageData = try? Data(contentsOf:  self.movie.poster) else { return }

    if isCancelled {
      return
    }

    if !imageData.isEmpty {
      self.movie.image = UIImage(data: imageData)
      self.movie.state = .downloaded
    } else {
      self.movie.image = nil
      self.movie.state = .failed
    }
  }
}

class PendingOperations {
  lazy var downloadInProgress: [IndexPath: Operation] = [:]

  lazy var downloadQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "com.dicoding.imagedownload"
    queue.maxConcurrentOperationCount = 2
    return queue
  }()
}
