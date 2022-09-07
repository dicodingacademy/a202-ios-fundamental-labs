//
//  ResultViewController.swift
//  DicodingDrop
//
//  Created by Gilang Ramadhan on 30/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
  private let _data: Data

  lazy var imageView: UIImageView = {
    let view = UIImageView()

    view.contentMode = .scaleAspectFit
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    view.image = UIImage(data: _data)

    return view
  }()

  lazy var btnShare: UIButton = {
    let view = UIButton()

    view.setTitle("Share", for: .normal)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)

    return view
  }()

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:)")
  }

  public init(data: Data) {
    _data = data

    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .black
    view.addSubview(imageView)
    view.addSubview(btnShare)

    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 300),
      imageView.heightAnchor.constraint(equalToConstant: 300),

      btnShare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      btnShare.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
    ])
  }

  @objc private func shareButtonDidTap() {
    let documents = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask
    ).first

    guard let path = documents?.appendingPathComponent("image.png") else { return }

    do {
      try _data.write(to: path, options: .atomicWrite)
    } catch {
      print(error.localizedDescription)
    }

    let activity = UIActivityViewController(
      activityItems: ["Coba lihat file ini", path],
      applicationActivities: nil
    )

    present(activity, animated: true)
  }
}
