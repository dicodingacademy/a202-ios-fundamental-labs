//
//  DownloadManager.swift
//  LatihanDownloadTaks
//
//  Created by Gilang Ramadhan on 12/08/22.
//

import UIKit

class DownloadManager: NSObject {
  static var shared = DownloadManager()

  var progress: ((Int64, Int64) -> ())?
  var completed: ((URL) -> ())?
  var downloadError: ((URLSessionTask, Error?) -> ())?

  lazy var session: URLSession = {
    let config = URLSessionConfiguration.background(withIdentifier: "com.dicoding.downloadTask")
    config.isDiscretionary = false
    return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
  }()
}

extension DownloadManager: URLSessionDelegate, URLSessionDownloadDelegate {
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64
  ) {
    if totalBytesExpectedToWrite > 0 {
      progress?(totalBytesWritten, totalBytesExpectedToWrite)
    }
  }

  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {
    completed?(location)
  }

  func urlSession(
    _ session: URLSession,
    task: URLSessionTask,
    didCompleteWithError error: Error?
  ) {
    downloadError?(task, error)
  }
}
