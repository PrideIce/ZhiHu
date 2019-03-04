//
//  ZHQuestionVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/4.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class ZHQuestionVC: ZHBaseVC {
    
    var offset: Int = 0
    var questionId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        QuestionProvider.request(.list(questionId, offset)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print(json)
                
                if let mappedObject = JSONDeserializer<ZHQuestion>.deserializeFrom(json: json.description) {
                    print(mappedObject)
                }
            }
        }
    }
    

}
