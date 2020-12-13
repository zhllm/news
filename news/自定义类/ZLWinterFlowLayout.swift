//
//  WinterFlowLayout.swift
//  news
//
//  Created by 张杰 on 2020/12/10.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class ZLWinterFlowLayout: UICollectionViewFlowLayout {
    var delegate: UICollectionViewDelegateFlowLayout?
    var attributes: [UICollectionViewLayoutAttributes] = []
    var xOffset: CGFloat = 0.0
    var yOffset: CGFloat = 0.0
    var maxEvenY: CGFloat = 0.0
    var maxOddY: CGFloat = 0.0
    var preLineCount = 0
    
    override func prepare() {
        super.prepare()
        // 总的个数
        let itemCount = self.collectionView?.numberOfItems(inSection: 0)
        // delegate 必须要实现 collectionView(_:layout:insetForSectionAt) 方法
        let sectionEdgeInsets = self.delegate!.collectionView!(self.collectionView!, layout: self, insetForSectionAt: 0)
        xOffset = sectionEdgeInsets.left
        yOffset = sectionEdgeInsets.top
        
        let indexPath = IndexPath(row: 0, section: 0)
        let size = self.delegate?.collectionView?(self.collectionView!, layout: self, sizeForItemAt: indexPath)
        let count = ceilf(
            Float((self.collectionView!.bounds.width - sectionEdgeInsets.left - sectionEdgeInsets.right + self.minimumInteritemSpacing) / (size!.width + self.minimumInteritemSpacing))
        )
        print(
            self.collectionView!.bounds.width,
            sectionEdgeInsets.left,
            sectionEdgeInsets.right,
            self.minimumInteritemSpacing,
            size!.width,
            self.minimumInteritemSpacing
        )
        preLineCount = Int(count)
        var yHeights: [CGFloat] = []
        for i in 0..<itemCount! {
            let indexPaths = IndexPath(item: i, section: 0) //IndexPath(row: i, section: 0)
            let itemSizes = self.delegate?.collectionView?(self.collectionView!, layout: self, sizeForItemAt: indexPaths)
            if (self.xOffset + sectionEdgeInsets.right + itemSizes!.width - 1) <=
                self.collectionView!.bounds.width {
                let attribute = self.layoutAttributesForItem(at: indexPaths)
                if yHeights.count == self.preLineCount {
                    self.yOffset = yHeights[i % self.preLineCount] + self.minimumLineSpacing
                }
                attribute!.frame = CGRect(x: self.xOffset, y: yOffset, width: itemSizes!.width, height: itemSizes!.height)
                attributes.append(attribute!)
                self.xOffset = self.xOffset + itemSizes!.width + self.minimumInteritemSpacing
                
                if yHeights.count < self.preLineCount {
                    yHeights.append(self.yOffset + itemSizes!.height)
                } else {
                    yHeights[i % preLineCount] = self.yOffset + itemSizes!.height
                }
            } else {
                self.xOffset = sectionEdgeInsets.left
                self.yOffset = yHeights[i % preLineCount] + self.minimumLineSpacing
                let attribute = layoutAttributesForItem(at: indexPaths)
                attribute!.frame = CGRect(x: xOffset, y: yOffset, width: itemSizes!.width, height: itemSizes!.height)
                attributes.append(attribute!)
                self.xOffset = self.xOffset + itemSizes!.width + self.minimumInteritemSpacing
                yHeights[i % preLineCount] = self.yOffset + itemSizes!.height
            }
        }
        for i in yHeights {
            yOffset = max(i, yOffset)
        }
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: self.collectionView!.bounds.size.width, height: self.yOffset)
        }
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

