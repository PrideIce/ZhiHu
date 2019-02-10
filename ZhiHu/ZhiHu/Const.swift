//
//  Const.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/9.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeigth = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
func isIPhoneXSeries() -> Bool {
    var isIPhoneXSeries : Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return isIPhoneXSeries
    }
    if #available(iOS 11.0, *) {
        let bottom : CGFloat = 0.0
        if (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > bottom {
            isIPhoneXSeries = true
        }
    }
    return isIPhoneXSeries
}

// statusBarHeight
let statusBarHeight : CGFloat = isIPhoneXSeries() ? 44 : 20

// navigationBarHeight
let navigationBarHeight : CGFloat = isIPhoneXSeries() ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIPhoneXSeries() ? 49 + 34 : 49

func RGBColor(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> UIColor {
    return UIColor.init(red: x/255, green: y/255, blue: z/255, alpha: 1)
}
