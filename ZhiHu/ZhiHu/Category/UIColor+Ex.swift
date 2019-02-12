//
//  UIColor+Ex.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/12.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// hexColor
    convenience init(hex: UInt32) {
        let r: CGFloat = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g: CGFloat = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b: CGFloat = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
