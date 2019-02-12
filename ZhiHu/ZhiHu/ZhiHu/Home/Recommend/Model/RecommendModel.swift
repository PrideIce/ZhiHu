//
//  RecommendModel.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/12.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import HandyJSON

struct RecommendModel: HandyJSON {
    var common_card:commonCard?
}

struct commonCard: HandyJSON {
    var style:String?
    var footline:FootLine?
    var ellipsis_menu:Ellipsis_menu?
    var feed_content:Feed_content?
}

struct FootLine: HandyJSON {
    var elements:[element]?
}

struct element: HandyJSON {
    var text:text?
}

//"color" : "GBK06A",
//"size" : 14,
//"max_line" : 1,
//"panel_text" : "4,744 赞同 · 1,052 评论",
//"weight" : "NORMAL"
struct text: HandyJSON {
    var color:String?
    var size:Int=14
    var max_line:Int=1
    var panel_text:String?
    var weight:String?
}

struct Ellipsis_menu: HandyJSON {
    
}

struct Feed_content: HandyJSON {
    var title:title?
    var content:content?
}

struct title: HandyJSON {
    var panel_text:String?
}

struct content: HandyJSON {
    var panel_text:String?
}
