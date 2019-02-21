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
    var common_card: CommonCard?
    var fields: MarketCard?
    var uninterest_reasons: [RecomUninterestReason]?
}

struct CommonCard: HandyJSON {
    var style: String?
    var footline: FootLine?
    var ellipsis_menu: Ellipsis_menu?
    var feed_content: Feed_content?
}

struct FootLine: HandyJSON {
    var elements: [RecomElement]?
}

struct RecomElement: HandyJSON {
    var text: RecomText?
}

struct RecomText: HandyJSON {
    var color: String?
    var size: Int = 14
    var max_line: Int = 1
    var panel_text: String?
    var weight: String?
}

struct Ellipsis_menu: HandyJSON {
}

// 内容
struct Feed_content: HandyJSON {
    var video: RecomVideo?
    var image: RecomImage?
    var title: Recom_title?
    var content: RecomContent?
}

struct Recom_title: HandyJSON {
    var panel_text: String?
}

struct RecomContent: HandyJSON {
    var panel_text: String?
}

struct RecomImage: HandyJSON {
    var image_url: String?
}

// 人员
struct RecomUninterestReason: HandyJSON {
    var object_token: String?
    var reason_type: String?
}

//    "id": "607be47c268359c0205067da833d571b",
//    "url_token": "ruan-mei-fan-zi",
//    "name": "软妹贩子",
//    "avatar_url": "https://pic2.zhimg.com/v2-643dedf1d18eef513e0f52f187f6db3d_is.jpg",
//    "avatar_url_template": "https://pic2.zhimg.com/v2-643dedf1d18eef513e0f52f187f6db3d_{size}.jpg",
//    "is_org": false,
//    "type": "people",
//    "url": "https://www.zhihu.com/people/ruan-mei-fan-zi",
//    "user_type": "people",
//    "headline": "国企民工 上八休八",
//    "gender": -1,
struct ZHMember: HandyJSON {
    var id: String?
    var url_token: String?
    var name: String?
    var avatar_url: String?
    var headline: String?
    var gender: Int?
}

// 视频
struct RecomVideo: HandyJSON {
    var id: String?
    var duration_in_seconds: Int?
    var thumbnail: RecomThumbnail?
    var playlist: RecomPlayList?
}

struct RecomThumbnail: HandyJSON {
    var image_url: String?
}

struct RecomPlayList: HandyJSON {
    var ld: Recomld?
}

struct Recomld: HandyJSON {
    var url: String?
}

// 大学
struct MarketCard: HandyJSON {
    var body: MarketBody?
    var header: MarketHeader?
}

struct MarketBody: HandyJSON {
    var title: String?
    var image: String?
    var url: String?
    var description: String?
}

struct MarketHeader: HandyJSON {
    var text: String?
    var image: String?
    var url: String?
}
