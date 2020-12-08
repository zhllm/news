//
//  IndexViewController.swift
//  news
//
//  Created by 张杰 on 2020/12/7.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class ZLIndexViewController: UIViewController {
    
    private lazy var subTitle: UILabel = {
        let label = UILabel.iconFont(from: .Index)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(subTitle)
        subTitle.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
