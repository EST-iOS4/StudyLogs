//
//  SimplePhotoCell.swift
//  PhotoClone
//
//  Created by Jungman Bae on 8/26/25.
//

import UIKit

class SimplePhotoCell: UICollectionViewCell {
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    contentView.backgroundColor = .secondarySystemBackground
    contentView.layer.cornerRadius = 8
    contentView.clipsToBounds = true

    // 이미지 뷰
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .systemGray
    imageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imageView)

    // 제목 레이블
    titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)

    // 부제목 레이블
    subtitleLabel.font = .systemFont(ofSize: 12)
    subtitleLabel.textColor = .secondaryLabel
    subtitleLabel.textAlignment = .center
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(subtitleLabel)

    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
      subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
    ])
  }

  func configure(with photo: ViewController.PhotoData) {
    imageView.image = UIImage(systemName: photo.imageName)

    let formatter = DateFormatter()
    formatter.dateStyle = .short
    titleLabel.text = formatter.string(from: photo.date)
    subtitleLabel.text = photo.id
  }

  func configure(title: String, subtitle: String) {
    imageView.image = UIImage(systemName: "photo.fill.on.rectangle.fill")
    titleLabel.text = title
    subtitleLabel.text = subtitle
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    titleLabel.text = nil
    subtitleLabel.text = nil
  }
}
