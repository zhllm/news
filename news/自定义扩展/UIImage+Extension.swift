//
//  UIImage+Extension.swift
//  news
//
//  Created by 张杰 on 2020/12/9.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    convenience init(from iconfont: IconFont, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize) {
        let drawText = iconfont
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let fontSize = min(size.width / 1.28571429, size.height)
        
        let attrbutes: [NSAttributedString.Key: Any] = [.font: UIFont.iconFont(ofSize: fontSize)!, .foregroundColor: textColor, .backgroundColor: backgroundColor, .paragraphStyle: paragraphStyle]
        
        let attrbuteString = NSAttributedString(string: drawText.rawValue, attributes: attrbutes)
        
        attrbuteString.draw(in: CGRect(x: 0, y: (size.height - fontSize) * 0.5, width: size.width, height: fontSize))
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image {
            self.init(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
        } else {
            self.init()
        }
    }
    
    static func icon(from font: IconFont, inconColor: UIColor, imageSize: CGSize, ofSize size: CGFloat) -> UIImage {
        let drawText = font.rawValue
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
         drawText.draw(in: CGRect(x:0, y:0, width:imageSize.width, height:imageSize.height), withAttributes: [.font: UIFont.iconFont(ofSize: size)!, .paragraphStyle: paragraphStyle, .foregroundColor: inconColor])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
