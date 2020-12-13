//
//  ZLDtaileViewController.swift
//  news
//
//  Created by 张杰 on 2020/12/7.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class ZLDtaileViewController: UIViewController, CAAnimationDelegate {

    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // spring()
        keyword()
    }
    
    /// keyword 关键帧动画
    func keyword() {
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(button)
        button.backgroundColor = .orange
        UIView.animateKeyframes(withDuration: 3, delay: 1, options: .allowUserInteraction) {
            self.button.frame = CGRect(x: 100, y: 200, width: 200, height: 400)
        } completion: { (complete) in
            print("\(complete)")
        }

    }
    
    /// 震动动画
    func spring() {
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(button)
        button.backgroundColor = .orange
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 8, options: .allowAnimatedContent) {
            self.button.frame = CGRect(x: 100, y: 200, width: 150, height: 200)
        } completion: { (complete) in
            print("\(complete)")
        }
    }

}
