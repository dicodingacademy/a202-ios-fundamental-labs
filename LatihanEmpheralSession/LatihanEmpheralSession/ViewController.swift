//
//  ViewController.swift
//  LatihanEmpheralSession
//
//  Created by Gilang Ramadhan on 12/08/22.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var label: UILabel!
  @IBOutlet var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    downloadImage()
  }

  private func downloadImage() {
    let path = "https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png"
    let url = URL(string: path)
    let configuration = URLSessionConfiguration.ephemeral
//    let configuration = URLSessionConfiguration.default


    let session = URLSession(configuration: configuration)

    if let response = configuration.urlCache?.cachedResponse(for: URLRequest(url: url!)) {
      label.text = "Use cache image"
      imageView.image = UIImage(data: response.data)
    } else {
      label.text = "Call image from network"

      let downloadTask = session.dataTask(with: url!) { [weak self] data, response, error in
        guard let self = self, let data = data else { return }

        DispatchQueue.main.async {
          self.imageView.image = UIImage(data: data)
        }
      }
      downloadTask.resume()
    }
  }

}

