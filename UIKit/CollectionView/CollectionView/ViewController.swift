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
    //    let layout = UICollectionViewFlowLayout()
    //    let numberOfColumns: CGFloat = 3
    //    let spacing: CGFloat = 10
    //    let totalSpacing = spacing * ( numberOfColumns - 1 ) + spacing * 2
    //
    //    let width = (view.frame.width - totalSpacing) / numberOfColumns
    //
    //    layout.itemSize = CGSize(width: width, height: width)
    //    layout.minimumInteritemSpacing = spacing
    //    layout.minimumLineSpacing = spacing
    //    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

    //    collectionView.collectionViewLayout = layout
    // 캐러셀
    //    collectionView.collectionViewLayout = CarouselLayout()
    // Pinterest
    //    let pinterestLayout = PinterestLayout()
    //    pinterestLayout.delegate = self
    //    collectionView.collectionViewLayout = pinterestLayout

    collectionView.collectionViewLayout = createLayout()


    collectionView
      .register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
  }

  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      switch sectionIndex {
      case 0: return self.createFeaturedSection()
      case 1: return self.createMediumSection()
      case 2: return self.createSmallSection()
      default: return self.createSmallSection()
      }
    }
    return layout
  }

  func createFeaturedSection() -> NSCollectionLayoutSection {
    // 아이템 크기: 부모의 100% 너비와 높이
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // 아이템 주변에 5포인트 여백 추가
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

    // 그룹 크기: 화면 너비의 90%, 고정 높이 300포인트
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                           heightDimension: .absolute(300))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // 섹션 생성
    let section = NSCollectionLayoutSection(group: group)
    // 수평 스크롤 동작: 그룹 단위로 페이징, 중앙 정렬
    section.orthogonalScrollingBehavior = .groupPagingCentered

    return section
  }

  func createMediumSection() -> NSCollectionLayoutSection {
    // 아이템 크기: 너비 50% (2열), 높이 100%
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

    // 그룹 크기: 전체 너비, 고정 높이 200포인트
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(200))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // 섹션 생성
    let section = NSCollectionLayoutSection(group: group)
    // 섹션 주변 여백 설정
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    // 섹션 헤더 추가
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(44)) // 예상 높이 44포인트
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                             alignment: .top) // 섹션 상단에 배치
    section.boundarySupplementaryItems = [header]

    return section

  }

  func createSmallSection() -> NSCollectionLayoutSection {
    // 아이템 크기: 너비 33.3% (3열), 높이 100%
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

    // 그룹 크기: 전체 너비, 고정 높이 120포인트
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(120))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // 섹션 생성
    let section = NSCollectionLayoutSection(group: group)
    // 연속적인 수평 스크롤 (페이징 없음)
    section.orthogonalScrollingBehavior = .continuous

    return section
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
    return sections[section].items.count * 4
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

extension ViewController: PinterestLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.item % 3 {
    case 0: return 50
    case 1: return 70
    case 2: return 100
    default:
      return 30
    }
  }
}
