//
//  ZLUILabel+Extension.swift
//  news
//
//  Created by 张杰 on 2020/12/9.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    class func iconFont(
            from iconfont: IconFont,
            size: CGFloat = 25,
            textColor: UIColor = .black
        ) -> UILabel {
        let label = UILabel()
        label.text = iconfont.rawValue
        label.textAlignment = .center
        label.font = UIFont.iconFont(ofSize: size)
        label.textColor = textColor
        return label
    }
}
