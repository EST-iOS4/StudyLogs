//
//  CarouselLayout.swift
//  CollectionView
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

class CarouselLayout: UICollectionViewFlowLayout {

  override func prepare() {
    super.prepare()

    guard let collectionView = collectionView else { return }

    scrollDirection = .horizontal

    let itemWidth = collectionView.bounds.width * 0.7
    let itemHeight = collectionView.bounds.height * 0.8
    itemSize = CGSize(width: itemWidth, height: itemHeight)

    let horizontalInset = (collectionView.bounds.width - itemWidth) / 2
    sectionInset = UIEdgeInsets(
      top: 0,
      left: horizontalInset,
      bottom: 0,
      right: horizontalInset
    )

    minimumLineSpacing = 20
  }

  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                    withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                       withScrollingVelocity: velocity)
    }

    let targetRect = CGRect(x: proposedContentOffset.x, y: 0,
                            width: collectionView.bounds.width,
                            height: collectionView.bounds.height)

    guard let layoutAttributes = layoutAttributesForElements(in: targetRect) else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                       withScrollingVelocity: velocity)
    }

    let centerX = proposedContentOffset.x + collectionView.bounds.width / 2

    let closest = layoutAttributes.min { abs($0.center.x - centerX) < abs($1.center.x - centerX) }

    guard let closestAttribute = closest else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                       withScrollingVelocity: velocity)
    }

    return CGPoint(x: closestAttribute.center.x - collectionView.bounds.width / 2,
                   y: proposedContentOffset.y)
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }

  override func  layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = collectionView,
          let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

    let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2

    return attributes.map { attribute in
      let distance = abs(attribute.center.x - centerX)
      let scale = max(0.8, 1 - (distance / collectionView.bounds.width))

      attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
      attribute.alpha = max(0.5, 1 - distance / collectionView.bounds.width)

      return attribute
    }
  }
}
