//
//  ViewController.swift
//  MyListMovie
//
//  Created by Gilang Ramadhan on 29/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

enum DownloadState {
    case new, downloaded, failed
}

class Movie {
    let title: String
    let poster: URL

    var image: UIImage?
    var state: DownloadState = .new

    init(title: String, poster: URL) {
        self.title = title
        self.poster = poster
    }
}

let movies = [
    Movie(title: "Captain America: The First Avenger", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMTYzOTc2NzU3N15BMl5BanBnXkFtZTcwNjY3MDE3NQ@@._V1_SX300.jpg")!),
    Movie(title: "The Toxic Avenger", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BNzViNmQ5MTYtMmI4Yy00N2Y2LTg4NWUtYWU3MThkMTVjNjk3XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!),
    Movie(title: "The Toxic Avenger Part II", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BODhiNTljYTctMmIzZC00ZGVkLTk2NmItN2RjMzY3ZTYyNDczXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!),
    Movie(title: "Citizen Toxie: The Toxic Avenger IV", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMWI0NWY0ODUtNGY3Yy00ZDU1LTllYjUtMDFkYWEzZGQwY2I1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!),
    Movie(title: "The Toxic Avenger Part III: The Last Temptation of Toxie", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BNjVlNzFjMGItMTEwYy00OTc0LWFmY2ItM2U0MmQyYWI5Njk3XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!),
    Movie(title: "Avenger", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMTMzMjMwMjcyNl5BMl5BanBnXkFtZTcwNTA1NDgzMQ@@._V1_SX300.jpg")!),
    Movie(title: "Knives of the Avenger", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BYmM1NGI1M2QtYWU2Zi00N2RjLWJjODgtYjhkN2ViOWY2YmEzXkEyXkFqcGdeQXVyNTE1MTU0Mzc@._V1_SX300.jpg")!),
    Movie(title: "Samurai Avenger: The Blind Wolf", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMTAwNjc4MTkyNjBeQTJeQWpwZ15BbWU3MDg3NTQyMzI@._V1_SX300.jpg")!),
    Movie(title: "The Avenger", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMjNmOTEzN2YtYTcyMC00NDQ1LTg5NTMtMjQ3M2ZlOGU2YmFkXkEyXkFqcGdeQXVyMzg1ODEwNQ@@._V1_SX300.jpg")!),
    Movie(title: "The Avenger", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BNzU5YzM3MmEtNTE2MS00MzVjLWI5Y2EtNGU3M2YwMGYzMGQ0XkEyXkFqcGdeQXVyMDExMzA0Mw@@._V1_SX300.jpg")!)
]

class ImageDownloader: Operation {
    private let _movie: Movie

    init(movie: Movie) {
        _movie = movie
    }

    override func main() {
        if isCancelled {
            return
        }

        guard let imageData = try? Data(contentsOf: _movie.poster) else { return }

        if isCancelled {
            return
        }

        if !imageData.isEmpty {
            _movie.image = UIImage(data: imageData)
            _movie.state = .downloaded
        } else {
            _movie.image = nil
            _movie.state = .failed
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

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let view = UITableView()

        view.delegate = self
        view.dataSource = self
        view.rowHeight = 150
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "movie-cell")

        return view
    }()

    private let _pendingOperations = PendingOperations()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    fileprivate func startOperations(movie: Movie, indexPath: IndexPath) {
        if movie.state == .new {
            startDownload(movie: movie, indexPath: indexPath)
        }
    }

    fileprivate func startDownload(movie: Movie, indexPath: IndexPath) {
        guard _pendingOperations.downloadInProgress[indexPath] == nil else { return }

        let downloader = ImageDownloader(movie: movie)
        downloader.completionBlock = {
            if downloader.isCancelled { return }

            DispatchQueue.main.async {
                self._pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        _pendingOperations.downloadInProgress[indexPath] = downloader
        _pendingOperations.downloadQueue.addOperation(downloader)
    }

    fileprivate func toggleSuspendOperations(isSuspended: Bool) {
        _pendingOperations.downloadQueue.isSuspended = isSuspended
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: false)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie-cell", for: indexPath)
        let movie = movies[indexPath.row]

        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = movie.title
        cell.imageView?.image = movie.image

        if cell.accessoryView == nil {
            cell.accessoryView = UIActivityIndicatorView(style: .medium)
        }

        guard let indicator = cell.accessoryView as? UIActivityIndicatorView else { fatalError() }

        if movie.state == .new {
            indicator.startAnimating()
            if !tableView.isDragging && !tableView.isDecelerating {
                startOperations(movie: movie, indexPath: indexPath)
            }
        } else {
            indicator.stopAnimating()
        }
        return cell
    }
}
