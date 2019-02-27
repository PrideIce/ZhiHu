//
//  AnswerAPI.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/21.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

// 首页推荐接口
let AnswerProvider = MoyaProvider<AnswerAPI>()

enum AnswerAPI {
    case detail(String)
}

extension AnswerAPI : TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .detail(let answerId):
            let urlString = "https://api.zhihu.com/v4/answers/" + answerId + "?with_pagination=1"
            return URL(string: urlString)!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .detail(_):
            return ""
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .detail(_):
            parmeters =  [:]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return ZHHeaders
    }
}
