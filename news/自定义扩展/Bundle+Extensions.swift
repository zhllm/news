//
//  Bundle+Extensions.swift
//  news
//
//  Created by 张杰 on 2020/12/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

extension Bundle {
    var namespcae: String? {
        return infoDictionary?["CFFFF"] as? String ?? ""
    }
}
