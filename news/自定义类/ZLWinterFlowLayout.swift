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
    
    override func prepare() {
        super.prepare()
        
        // 总的个数
        let count = self.collectionView?.numberOfItems(inSection: 0)
        let sectionEdgeInsets = self.delegate!.collectionView!(self.collectionView!, layout: self, insetForSectionAt: 0)
        // let sectionEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        xOffset = sectionEdgeInsets.left
        yOffset = sectionEdgeInsets.top
        maxOddY = yOffset
        maxEvenY = yOffset
        
        for i in 0..<count! {
            let indexPath = IndexPath(item: i, section: 0)
            let itemSize = self.delegate?.collectionView?(self.collectionView!, layout: self, sizeForItemAt: indexPath)
            if i % 2 == 0 {
                xOffset = sectionEdgeInsets.left
                yOffset = maxEvenY
            } else {
                xOffset = sectionEdgeInsets.left + itemSize!.width + self.minimumInteritemSpacing
                yOffset = maxOddY
            }
            let attribute = self.collectionView!.layoutAttributesForItem(at: indexPath)
            attribute?.frame = CGRect(x: xOffset, y: yOffset, width: itemSize!.width, height: itemSize!.height)
            attributes.append(attribute!)
            if i % 2 == 0 {
                maxEvenY = maxEvenY + sectionEdgeInsets.top + itemSize!.height + self.minimumLineSpacing
            } else {
                maxOddY = maxOddY + sectionEdgeInsets.top + itemSize!.height + self.minimumLineSpacing
            }
        }
        
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            let height = max(self.maxOddY, self.maxEvenY)
            return CGSize(width: self.collectionView!.bounds.size.width, height: height)
        }
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
