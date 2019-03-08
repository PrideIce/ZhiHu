//
//  CommentModel.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/8.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import HandyJSON

struct CommentListModel: HandyJSON {
    var common_counts: Int = 0
    var data: [CommentModel]?
}

struct CommentModel: HandyJSON {
    var content: String?
    var id: String?
    var created_time: String?
    var vote_count: Int = 0
    var author: ComAuthor?
    var reply_to_author: ComAuthor?
    var child_comment_count: Int = 0
    var child_comments: [CommentModel]?
}

struct ComAuthor: HandyJSON {
    var role: String?
    var member: ZHAuthor?
}
