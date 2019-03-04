//
//  HotListModel.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/14.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import HandyJSON

struct HotListModel: HandyJSON {
    var target: hotListTarget?
    var card_id: String?
}

struct hotListTarget: HandyJSON {
    var title_area: hotListTitle?
    var image_area: hotListImage?
    var link: hotListLink?
    var metrics_area: hotMetricsArea?
}

struct hotMetricsArea: HandyJSON {
    var text: String?
}

struct hotListImage: HandyJSON {
    var url: String?
}

struct hotListLink: HandyJSON {
    var url: String?
}

struct hotListTitle: HandyJSON {
    var text: String?
}
