//
//  QuestionDetailVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/21.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnswerDetailVC: ZHViewController {
    
    var answerUrl: String? {
        didSet {
            let strArray = answerUrl?.split(separator: "/")
            self.answerId = String(strArray?.last ?? "")
        }
    }
    var answerId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        AnswerProvider.request(.detail(self.answerUrl!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print(json)
            }
        }
    }


}
