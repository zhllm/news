//
//  ZLBottomNavController.swift
//  news
//
//  Created by 张杰 on 2020/12/7.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import Kingfisher

class ZLBottomNavController: UITabBarController {
    
    var items: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let indexView = ZLIndexViewController()
        let navIndex = UINavigationController(rootViewController: indexView)
        navIndex.title = "首页"
        navIndex.tabBarItem.image = UIImage.icon(from: .Index, inconColor: .black, imageSize: CGSize(width: 36, height: 36), ofSize: 28)
        
        let detailView = ZLDtaileViewController()
        let navDetail = UINavigationController(rootViewController: detailView)
        detailView.title = "详情"
        
        let activity = ZLActivityViewController()
        let navActivity = UINavigationController(rootViewController: activity)
        navActivity.title = "活动页"
        
        let pCenter = ZLPersionCenterViewController()
        let navPCenter = UINavigationController(rootViewController: pCenter)
        navPCenter.title = "个人中心"
        
        items = [navIndex, navDetail, navActivity, navPCenter]
        
        self.viewControllers = items
    }

}
