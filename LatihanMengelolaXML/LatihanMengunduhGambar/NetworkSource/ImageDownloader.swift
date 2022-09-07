//
//  ImageDownloader.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 05/08/22.
//

import UIKit

class ImageDownloader {

  func downloadImage(url: URL) async throws -> UIImage {
    async let imageData: Data = try Data(contentsOf: url)
    return UIImage(data: try await imageData)!
  }
}
