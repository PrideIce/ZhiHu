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
    var fields:MarketCard?
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
    var video:RecomVideo?
    var image:RecomImage?
    var title:title?
    var content:content?
}

struct title: HandyJSON {
    var panel_text:String?
}

struct content: HandyJSON {
    var panel_text:String?
}

struct RecomImage: HandyJSON {
    var image_url:String?
}

//视频
struct RecomVideo: HandyJSON {
    var id:String?
    var duration_in_seconds:Int?
    var thumbnail:RecomThumbnail?
    var playlist:RecomPlayList?
}

struct RecomThumbnail: HandyJSON {
    var image_url:String?
}

struct RecomPlayList: HandyJSON {
    var ld:ld?
}

struct ld:HandyJSON {
    var url:String?
    
}

//大学
struct MarketCard:HandyJSON {
    var body:MarketBody?
}

struct MarketBody:HandyJSON {
    var title:String?
    var image:String?
    var url:String?
    var description:String?
}
