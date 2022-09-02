//
//  ViewController.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 04/08/22.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var movieTableView: UITableView!
  private let pendingOperations = PendingOperations()

  override func viewDidLoad() {
    super.viewDidLoad()
    movieTableView.dataSource = self

    movieTableView.register(
      UINib(nibName: "MovieTableViewCell", bundle: nil),
      forCellReuseIdentifier: "movieTableViewCell"
    )
  }
}

extension ViewController: UIScrollViewDelegate {
  fileprivate func toggleSuspendOperations(isSuspended: Bool) {
    pendingOperations.downloadQueue.isSuspended = isSuspended
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    toggleSuspendOperations(isSuspended: true)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    toggleSuspendOperations(isSuspended: false)
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
        startOperations(movie: movie, indexPath: indexPath)
      } else {
        cell.indicatorLoading.stopAnimating()
        cell.indicatorLoading.isHidden = true
      }

      return cell
    } else {
      return UITableViewCell()
    }
  }

  fileprivate func startOperations(movie: Movie, indexPath: IndexPath) {
    if movie.state == .new {
      startDownload(movie: movie, indexPath: indexPath)
    }
  }

  fileprivate func startDownload(movie: Movie, indexPath: IndexPath) {
    guard pendingOperations.downloadInProgress[indexPath] == nil else { return }

    let downloader = ImageDownloader(movie: movie)

    downloader.completionBlock = {
      if downloader.isCancelled { return }
      DispatchQueue.main.async {
        self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
        self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
      }
    }

    pendingOperations.downloadInProgress[indexPath] = downloader
    pendingOperations.downloadQueue.addOperation(downloader)
  }

}
