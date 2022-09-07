//
//  MovieTableViewCell.swift
//  LatihanMengunduhGambar
//
//  Created by Gilang Ramadhan on 04/08/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  @IBOutlet var movieImage: UIImageView!
  @IBOutlet var movieTitle: UILabel!
  @IBOutlet var indicatorLoading: UIActivityIndicatorView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(
    _ selected: Bool,
    animated: Bool
  ) {
    super.setSelected(selected, animated: animated)
  }
}
