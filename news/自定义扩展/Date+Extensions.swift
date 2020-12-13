//
//  Data+Extensions.swift
//  news
//
//  Created by 张杰 on 2020/12/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

/// 日期格式化器 不要频繁的释放和创建
private let dateFormatter = DateFormatter()

/// 当前日历对象
private let calendar = Calendar.current

extension Date {
    
    /// 计算与当前系统偏差delta 秒数的日期字符串
    /// 结构体 static 修饰静态方法，class 只能修饰类的静态方法以及计算属性
    static func zl_dateString(delta: TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: delta)
        
        // 指定格式日期
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    /// 将新浪格式的字符串转换成日期
    ///
    /// - parameter string: Tue Sep 15 12:12:00 +0800 2015
    ///
    /// - returns: 日期
    static func zl_sinaDate(string: String?) -> Date? {
        
        // 1. 设置日期格式(新浪自己的特殊日期格式)
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        // 2. 转换并且返回日期
        return dateFormatter.date(from: string ?? "")
    }
    
    var zl_dateDesciption: String {
        if calendar.isDateInToday(self) {
            let delta = -Int(self.timeIntervalSinceNow)
            
            if delta < 60 {
                return "刚刚"
            } else if delta < 3600 {
                return "\(delta / 60) 分钟前"
            }
            return "\(delta / 3600) 小时前"
        }
        var fmt = " HH:mm"
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        } else {
            fmt = "MM-dd" + fmt
            let year = calendar.component(.year, from: self)
            let thisYears = calendar.component(.year, from: Date())
            
            if year != thisYears {
                fmt = "yyyy-" + fmt
            }
        }
        dateFormatter.dateFormat = fmt
        return dateFormatter.string(from: self)
    }
}

