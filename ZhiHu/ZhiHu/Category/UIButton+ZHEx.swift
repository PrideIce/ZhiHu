//
//  UIButton+ZHEx.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/10.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func blueTheme() {
        setTitleColor(RGBColor(0, 125, 255), for: UIControlState.normal)
//        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
