//
//  SectionHeaderView.swift
//  CollectionView
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  func configure(title: String, count: Int) {
    titleLabel.text = title
    countLabel.text = "\(count) 개"
  }
}
