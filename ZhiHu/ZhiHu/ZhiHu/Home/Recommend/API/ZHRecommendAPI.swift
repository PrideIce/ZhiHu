//
//  ZHRecommendAPI.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/11.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

// 首页推荐接口
let ZHRecommendProvider = MoyaProvider<ZHRecommendAPI>()

enum ZHRecommendAPI {
    case followList(Int)  //关注
    case recommendList(Int)  //推荐列表
    case hotList(Int)  //热榜
    case videoList(Int)  //视频
}

extension ZHRecommendAPI : TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: "https://api.zhihu.com")!
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .followList(_):
            return ""
        case .recommendList(_):
            return "/topstory/recommend"
        case .hotList(_):
            return "/topstory/hot-list"
        case .videoList(_):
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
        case .followList(let index):
            parmeters =  [
                "limit":10,
                "page_number":index
            ]
        case .recommendList(let index):
            parmeters =  [
                "action_feed":true,
                "limit":10,
                "reverse_order":0,
                "scroll":"up",
                "start_type":"cold",
                "page_number":index
            ]
        case .hotList(let index):
            parmeters =  [
                "limit":10,
                "page_number":index,
                "reverse_order":0
            ]
        case .videoList(let index):
            parmeters =  [
                "limit":10,
                "page_number":index
            ]
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
