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

  // 데이터를 담는 구조체들
  struct PhotoData {
    let id: String
    let imageName: String
    let date: Date
  }

  // 각 섹션의 샘플 데이터
  var photos: [PhotoData] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Photo Clone"
    view.backgroundColor = .systemBackground

    collectionView.dataSource = self
    collectionView.delegate = self

    loadSampleData()

    registerCells()

  }

  // 셀 등록
  func registerCells() {
    collectionView.register(SimplePhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
  }


  func loadSampleData() {
    // 샘플 사진 데이터 생성
    let calendar = Calendar.current
    let today = Date()

    photos = (1...50).map { index in
      let daysAgo = -index
      let date = calendar.date(byAdding: .day, value: daysAgo, to: today) ?? today

      return PhotoData(
        id: "photo_\(index)",
        imageName: "photo.fill",  // 시스템 아이콘 사용
        date: date
      )
    }

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

  // 특집 섹션 (큰 카드)
  func createFeaturedSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.85),
      heightDimension: .absolute(250)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.interGroupSpacing = 10
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    // 섹션 헤더
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(44)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    section.boundarySupplementaryItems = [header]

    return section
  }

  // 중간 그리드 섹션 (2열)
  func createMediumGridSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(160)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    // 섹션 헤더
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(44)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    section.boundarySupplementaryItems = [header]

    return section
  }

  func createSmallGridSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .absolute(100),
      heightDimension: .absolute(100)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .absolute(100),
      heightDimension: .absolute(100)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    // 섹션 헤더
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(44)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    section.boundarySupplementaryItems = [header]

    return section
  }

  func createMainGridSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0/3),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1.0/3)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)

    return section
  }
}

extension ViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = Section(rawValue: section) else { return 0 }

    switch sectionType {
    case .years:
      return 3  // 3개의 연도
    case .months:
      return 6  // 6개의 월
    case .days:
      return 10 // 10개의 일
    case .allPhotos:
      return photos.count
    }

  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! SimplePhotoCell

    guard let sectionType = Section(rawValue: indexPath.section) else {
      return cell
    }

    // 섹션별로 다른 설정
    switch sectionType {
    case .years:
      cell.configure(title: "202\(indexPath.item + 2)", subtitle: "\(100 * (indexPath.item + 1))장")
    case .months:
      cell.configure(title: "\(indexPath.item + 1)월", subtitle: "\(50 + indexPath.item * 10)장")
    case .days:
      cell.configure(title: "\(indexPath.item + 1)일", subtitle: "\(10 + indexPath.item)장")
    case .allPhotos:
      if indexPath.item < photos.count {
        let photo = photos[indexPath.item]
        cell.configure(with: photo)
      }
    }

    return cell
  }


}

extension ViewController: UICollectionViewDelegate {

}
