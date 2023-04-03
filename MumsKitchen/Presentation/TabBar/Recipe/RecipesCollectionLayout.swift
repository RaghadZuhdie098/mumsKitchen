//
// 
// RecipesCollectionLayout.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//

// implemented by this resource : https://www.kodeco.com/4829472-uicollectionview-custom-layout-tutorial-pinterest

import UIKit

protocol RecipesCollectionLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForLabelAtIndexPath indexPath: IndexPath, columnWidth: CGFloat) -> CGFloat
}

class RecipesCollectionLayout: UICollectionViewLayout {

    // 1
    weak var delegate: RecipesCollectionLayoutDelegate?

    // 2
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6

    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []

    // 4
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        // 1
        guard let collectionView = collectionView else { return }

        cache = []
        // 2
        let columnWidth = contentWidth / CGFloat(numberOfColumns) // 194
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)

        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            // 4
            let labelHeight = delegate?.collectionView(
                collectionView,
                heightForLabelAtIndexPath: indexPath, columnWidth: columnWidth) ?? 0
            let height = cellPadding * 2 + labelHeight 
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }

    }

    override func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

//    override func layoutAttributesForItem(at indexPath: IndexPath)
//    -> UICollectionViewLayoutAttributes? {
//        return cache[indexPath.item]
//    }


}
