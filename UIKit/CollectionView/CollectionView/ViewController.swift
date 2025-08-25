//
//  ViewController.swift
//  CollectionView
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!

  let colors: [UIColor] = [
    .systemRed, .systemBlue, .systemGreen, .systemYellow,
    .systemPurple, .systemOrange, .systemPink, .systemTeal,
    .systemIndigo, .systemBrown, .systemGray, .systemCyan
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.delegate = self

    setupLayout()
  }

  func setupLayout() {
    let layout = UICollectionViewFlowLayout()
    let numberOfColumns: CGFloat = 3
    let spacing: CGFloat = 10
    let totalSpacing = spacing * ( numberOfColumns - 1 ) + spacing * 2

    let width = (view.frame.width - totalSpacing) / numberOfColumns

    layout.itemSize = CGSize(width: width, height: width)
    layout.minimumInteritemSpacing = spacing
    layout.minimumLineSpacing = spacing
    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

    collectionView.collectionViewLayout = layout
    collectionView
      .register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors.count * 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

    cell.backgroundColor = colors[indexPath.row % colors.count]
    cell.layer.cornerRadius = 8

    return cell
  }
}

extension ViewController: UICollectionViewDelegate {

}
