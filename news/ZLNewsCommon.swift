//
//  ZLNewsCommon.swift
//  news
//
//  Created by 张杰 on 2020/12/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import UIKit

// MARK: - App infomation
let ZLAppKey = "1368316550"

let ZLAppSecret = "df5dc1bd561b735f025c6b637a7c25bb"

let ZLredirectUrl = "https://baidu.com"

// MARK: - global notification

let ZLUserShouldLoginNotification = "ZLUserShouldLoginNotification"
let ZLUserLoginSuccessNotification = "ZLUserLoginSuccessNotification"

/// 微博Cell浏览照片
/// @param urlString   urlString 字符串
/// @param photoIndex  照片索引
/// @param placeholder 占位图像
let ZLNewsCellBrowserPhotoNotification = "ZLNewsCellBrowserPhotoNotification"

let ZLNewsCellBrowserPhotoIndexKey = "ZLNewsCellBrowserPhotoIndexKey"
let ZLNewsCellBrowserPhotoURLsKeys = "ZLNewsCellBrowserPhotoURLsKeys"
let ZLNewsCellBrowserPhotoImageViewsKeys = "ZLNewsCellBrowserPhotoImageViewsKeys"

let ZLDefaultMargin = ZLLayout.Layout(12)
let ZLStatusPictureOutterMargin = ZLLayout.Layout(12)
let ZLStatusPictureInnerMargin = ZLLayout.Layout(5)

let ZLPictureMaxPerLine: CGFloat = 3

let ZLMainScreenWeidth = UIScreen.main.bounds.size.width
let ZLMainScreenHeight = UIScreen.main.bounds.size.height

let ZLPictureViewWidth = ZLMainScreenWeidth - (2 * ZLStatusPictureOutterMargin)

let ZLPictureItemWidth = (ZLPictureViewWidth - (2 * ZLStatusPictureInnerMargin)) / ZLPictureMaxPerLine

// MARK: - IphoneX
let ZL_iphoneX = (ZLMainScreenWeidth >= 375) && (ZLMainScreenHeight >= 812)

let ZL_statusBarHeight: CGFloat = ZL_iphoneX ? 44 : 20

let ZL_naviContentHeight: CGFloat = 44

let ZL_bottomTabBarContentHeight: CGFloat = 49

let ZL_bottomTabBarSpacing: CGFloat = ZL_iphoneX ? 34 : 0

let ZL_bottomTabBarHeight = ZL_iphoneX ? (ZL_bottomTabBarSpacing + ZL_naviContentHeight) : ZL_bottomTabBarContentHeight

let ZL_naviBarHeight: CGFloat = ZL_statusBarHeight + ZL_naviContentHeight









