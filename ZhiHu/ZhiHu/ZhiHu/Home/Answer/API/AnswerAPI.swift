//
//  QuestionAPI.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/4.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

// 首页推荐接口
let AnswerProvider = MoyaProvider<AnswerAPI>()

enum AnswerAPI {
    case list(String, Int)
    case detail(String)
    case question(String)
    case commentList(String, Int)
}

extension AnswerAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        return URL(string: "https://api.zhihu.com")!
    }

    // 各个请求的具体路径
    public var path: String {
        switch self {
        case let .list(questionId, _):
            return "/v4/questions/" + questionId + "/answers"
        case let .detail(answerId):
            return "/v4/answers/" + answerId
        case let .question(answerId):
            return "/v4/answers/" + answerId + "/question"
        case let .commentList(answerId, _):
            return "/answers/" + answerId + "/root_comments"
        }
    }

    // 请求类型
    public var method: Moya.Method {
        return .get
    }

    // 请求任务事件（这里附带上参数）
    public var task: Task {
        var parmeters: [String: Any] = [:]
        switch self {
        case let .list(_, offset):
            parmeters = ["limit": 10,
                         "offset": offset,
                         "reverse_order": 0,
                         "show_detail": 1]
        case .detail:
            parmeters = ["with_pagination": 1]
        case let .commentList(_,offset):
            parmeters = ["limit": 10,
                         "offset": offset]
        default:
            return .requestPlain            
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }

    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    // 请求头
    public var headers: [String: String]? {
        return ZHHeaders
    }
}
