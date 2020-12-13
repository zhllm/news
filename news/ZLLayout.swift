//
//  ZLLayout.swift
//  news
//
//  Created by 张杰 on 2020/12/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

struct ZLLayout {
    static let ratio: CGFloat = UIScreen.main.bounds.size.width / 375.0
    static func Layout(_ number: CGFloat) -> CGFloat {
        return number * ratio
    }
}
