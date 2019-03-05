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

let StatusBarHeight : CGFloat = isIPhoneXSeries() ? 44 : 20
let NavigationBarHeight : CGFloat = isIPhoneXSeries() ? 88 : 64
let TabBarHeight : CGFloat = isIPhoneXSeries() ? 49 + 34 : 49
let SafeBottomHeight : CGFloat = isIPhoneXSeries() ? 34 : 0
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
let BGColor = FooterViewColor
let ThemeColorBlue = UIColor.init(hex: 0x0B92FF)

func RGBColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
}



