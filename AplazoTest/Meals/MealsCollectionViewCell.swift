//
//  CollectionViewCell.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import UIKit

class MealsCollectionViewCell: UICollectionViewCell {
  static let identifier = "MealsCollectionViewCell"

 
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()

  let title: UILabel = {
    let title = UILabel()
    title.numberOfLines = 2
    title.adjustsFontSizeToFitWidth = true
    title.contentMode = .scaleAspectFill
    title.textAlignment = .center
    title.font = .boldSystemFont(ofSize: 20)
    return title
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(title)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = contentView.bounds
    title.frame = contentView.bounds
  }

  override func prepareForReuse() {
    super.prepareForReuse()
  }
}
