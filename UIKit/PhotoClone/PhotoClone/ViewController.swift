//
//  ViewController.swift
//  PhotoClone
//
//  Created by Jungman Bae on 8/26/25.
//

import UIKit

class ViewController: UIViewController {

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: self.createLayout())
    self.view.addSubview(collectionView)
    return collectionView
  }()


  enum Section: Int, CaseIterable {
    case years
    case months
    case days
    case allPhotos

    var title: String {
      switch self {
      case .years: return "연도"
      case .months: return "월"
      case .days: return "일"
      case .allPhotos: return "모든 사진"
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Photo Clone"
    view.backgroundColor = .systemBackground
  }

  func createLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
      guard let section = Section(rawValue: sectionIndex) else { return nil }

      switch section {
      case .years:
        return self?.createFeaturedSection()
      case .months:
        return self?.createMediumGridSection()
      case .days:
        return self?.createSmallGridSection()
      case .allPhotos:
        return self?.createMainGridSection()
      }
    }
  }

  func createFeaturedSection() -> NSCollectionLayoutSection {
    return NSCollectionLayoutSection(
      group: NSCollectionLayoutGroup(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )
    )
  }


  func createMediumGridSection() -> NSCollectionLayoutSection {
    return NSCollectionLayoutSection(
      group: NSCollectionLayoutGroup(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )
    )

  }

  func createSmallGridSection() -> NSCollectionLayoutSection {
    return NSCollectionLayoutSection(
      group: NSCollectionLayoutGroup(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )
    )

  }

  func createMainGridSection() -> NSCollectionLayoutSection {
    return NSCollectionLayoutSection(
      group: NSCollectionLayoutGroup(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )
    )
  }
}

