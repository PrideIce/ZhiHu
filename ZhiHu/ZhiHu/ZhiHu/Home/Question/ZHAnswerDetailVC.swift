//
//  ZHAnswerDetailVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/27.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import WebKit
import Moya
import HandyJSON
import SwiftyJSON

class ZHAnswerDetailVC: ZHViewController {
    
    var answerId: String? {
        didSet {
            webView.scrollView.mj_header.endRefreshing()
            webView.scrollView.mj_footer.endRefreshing()
            let urlString = "https://www.zhihu.com/appview/v2/answer/" + answerId!
            let contentURL = URL(string: urlString)
            var request = URLRequest(url: contentURL!)
            request.allHTTPHeaderFields = ZHHeaders
            webView.load(request)
        }
    }
    
    var webView: WKWebView = {
        let webView = WKWebView()
        
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.text = "查看上一个答案"
        webView.scrollView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter()
        footer.stateLabel.text = "查看下一个答案"
        webView.scrollView.mj_footer = footer
        
        return webView
    }()
    
    var answerIdList: [String]?
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "问题详情"
        view.backgroundColor = .white

        self.view.addSubview(webView)
        webView.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(NavigationBarHeight)
        })
        
        webView.scrollView.mj_header.refreshingBlock = { [weak self] in
            if self?.index ?? 0 > 0 {
                self?.index -= 1
                self?.answerId = self?.answerIdList?[self?.index ?? 0]
            } else {
                self?.webView.scrollView.mj_header.endRefreshing()
            }
        }
        
        webView.scrollView.mj_footer.refreshingBlock = { [weak self] in
            self?.index += 1
            if self?.index ?? 0 < self?.answerIdList?.count ?? 0 {
                self?.answerId = self?.answerIdList?[self?.index ?? 0]
            } else {
                self?.index = (self?.answerIdList?.count ?? 1) - 1
                self?.webView.scrollView.mj_footer.endRefreshingWithNoMoreData()
            }
        }
        
        self.answerIdList = [self.answerId!]
        AnswerProvider.request(.detail(answerId!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print(json)
                
                if let mappedObject = JSONDeserializer<ZHFirstAnswer>.deserializeFrom(json: json.description) {
                    self.answerIdList? += mappedObject.pagination_info?.next_answer_ids ?? []
                    print(self.answerIdList!)
                }
            }
        }
    }
    

}
