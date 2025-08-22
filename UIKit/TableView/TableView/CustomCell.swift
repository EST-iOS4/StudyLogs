//
//  CustomCell.swift
//  TableView
//
//  Created by Jungman Bae on 8/22/25.
//

import UIKit

class CustomCell: UITableViewCell {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.textColor = .systemGray
    label.frame = CGRect(x: 15, y: 10, width: 200, height: 20)
    return label
  }()

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  private func setupUI() {
    self.contentView.addSubview(titleLabel)
    contentView.backgroundColor = .systemMint
  }

  func configure(with title: String) {
    titleLabel.text = title
  }
}
