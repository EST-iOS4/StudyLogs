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
    var items: [UIColor]
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

    collectionView.dragDelegate = self
    collectionView.dropDelegate = self
    collectionView.dragInteractionEnabled = true
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

    let section = sections[indexPath.section]
    cell.backgroundColor = section.items[indexPath.item]
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

// MARK: - UICollectionViewDragDelegate
extension ViewController: UICollectionViewDragDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      itemsForBeginning session: UIDragSession,
                      at indexPath: IndexPath) -> [UIDragItem] {
    // 선택된 아이템 가져오기
    let section = sections[indexPath.section]
    let item = section.items[indexPath.item]

    // NSItemProvider를 생성하여 드래그할 데이터 설정
    let itemProvider = NSItemProvider(object: item as UIColor)
    // UIDragItem 생성
    let dragItem = UIDragItem(itemProvider: itemProvider)
    // 로컬 객체로 원본 데이터 저장 (앱 내에서만 사용)
    dragItem.localObject = item

    return [dragItem]
  }
}

// MARK: - UICollectionViewDropDelegate
extension ViewController: UICollectionViewDropDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    performDropWith coordinator: UICollectionViewDropCoordinator
  ) {
    // 드롭 위치가 유효한지 확인
    guard let destinationIndexPath = coordinator.destinationIndexPath else { return }

    // 모든 드롭 아이템에 대해 처리
    coordinator.items.forEach { dropItem in
      // 소스 위치와 드래그된 아이템이 유효한지 확인
      guard let sourceIndexPath = dropItem.sourceIndexPath,
            let item = dropItem.dragItem.localObject as? UIColor else { return }

      // 배치 업데이트를 사용하여 애니메이션과 함께 이동 처리
      collectionView.performBatchUpdates({

        // 컬렉션 뷰에서 시각적 이동 처리
        collectionView.deleteItems(at: [sourceIndexPath])      // 원래 셀 삭제
        collectionView.insertItems(at: [destinationIndexPath]) // 새 위치에 셀 삽입

        // 데이터 소스에서 아이템 이동
        sections[sourceIndexPath.section].items.remove(at: sourceIndexPath.item)      // 원래 위치에서 제거
        sections[destinationIndexPath.section].items.insert(item, at: destinationIndexPath.item) // 새 위치에 삽입

      })

      // 드롭 애니메이션 실행
      coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      dropSessionDidUpdate session: UIDropSession,
                      withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    // 같은 앱 내에서의 드래그인지 확인
    if session.localDragSession != nil {
      // 이동 동작으로 설정하고 목적지 인덱스 위치에 삽입
      return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    // 외부 앱에서의 드래그는 금지
    return UICollectionViewDropProposal(operation: .forbidden)
  }
}
