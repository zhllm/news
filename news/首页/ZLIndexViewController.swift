//
//  IndexViewController.swift
//  news
//
//  Created by 张杰 on 2020/12/7.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ZLIndexViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    var collectionView:UICollectionView!
    
    let heights = [100, 150, 150,
                   50, 130, 180,
                   200, 100, 110,
                   200, 90, 100,
                   150, 150, 50,
                   130, 180, 200, 100, 110, 200, 90, 100, 150, 150, 50, 130, 180, 200, 100, 110, 200, 90]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let layout = ZLWinterFlowLayout.init()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.delegate = self
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        self.view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.contentView.backgroundColor = .white
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let image = UIImageView()
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.contentView.addSubview(image)
        image.kf.setImage(with: URL(string: "https://pixabay.com/get/55e0d340485aa814f6da8c7dda793677163ddde256556c48732f7cd39f4ec059bd_1280.jpg"))
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(2)
        let space = CGFloat(10 * 2)
        let inerSpace = CGFloat(10 * (count - 1))
        let width = self.view.bounds.size.width - inerSpace - space
        let height = width / count // CGFloat(heights[indexPath.row])
        return CGSize(width: width / count, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
