//
//  AnswerModel.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/22.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import HandyJSON

//Question
struct ZHQuestion: HandyJSON {
    var title: String?
    var answer_count: Int?
}

//Answer
struct ZHFirstAnswer: HandyJSON {
    var excerpt: String?
    var voteup_count: Int?
    var pagination_info: AnswerIdList?
    var author: ZHAuthor?
}

struct AnswerIdList: HandyJSON {
    var next_answer_ids: [String]?
}

struct ZHAuthor: HandyJSON {
    var is_followed: Bool?
    var gender: Int?
    var avatar_url: String?
    var headline: String?
    var id: String?
    var name: String?
    var is_privacy: Bool?
}
