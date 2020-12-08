//
//  ZLUILabel+Extension.swift
//  news
//
//  Created by 张杰 on 2020/12/8.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import Foundation

public extension UIFont {
    class func iconFont(ofSize: CGFloat) -> UIFont? {
        return UIFont.init(name: "iconFont", size: ofSize)
    }
}

public enum IconFont: String {
    case Index = "\u{e60b}"
    case Detail = "\u{e641}"
    case Activity = "\u{e609}"
    case Person = "\u{e64e}"
}

