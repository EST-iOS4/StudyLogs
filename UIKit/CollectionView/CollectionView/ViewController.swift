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

  struct Section {
    let title: String
    let items: [UIColor]
  }

  var sections: [Section] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.delegate = self

    setupLayout()
    setupSections()

    let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
    collectionView
      .register(
        headerNib,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: "SectionHeader"
      )
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

    //    collectionView.collectionViewLayout = layout
    // 캐러셀
    collectionView.collectionViewLayout = CarouselLayout()
    collectionView
      .register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
  }

  func setupSections() {
    sections = [
      Section(title: "1번째", items: colors),
      Section(title: "2번째", items: colors),
      Section(title: "3번째", items: colors),
    ]
  }
}

extension ViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sections[section].items.count
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "SectionHeader",
        for: indexPath
      ) as! SectionHeaderView

      let section = sections[indexPath.section]

      header.configure(title: section.title, count: section.items.count)

      return header
    }
    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

    cell.backgroundColor = colors[indexPath.row % colors.count]
    cell.layer.cornerRadius = 8

    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 50)
  }
}
