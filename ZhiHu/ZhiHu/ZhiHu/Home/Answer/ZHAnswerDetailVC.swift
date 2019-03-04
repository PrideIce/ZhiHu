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

class ZHAnswerDetailVC: ZHBaseVC {
    
    var answerId: String? {
        didSet {
            webView.scrollView.mj_header.endRefreshing()
            webView.scrollView.mj_footer.endRefreshing()
            let urlString = "https://www.zhihu.com/appview/v2/answer/" + answerId!
            print("AURL: " + urlString)
            let contentURL = URL(string: urlString)
            var request = URLRequest(url: contentURL!)
            request.allHTTPHeaderFields = ZHHeaders
            webView.load(request)
            webView.navigationDelegate = self
        }
    }
    
    var webView: WKWebView = {
        let webView = WKWebView()
        
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.text = "查看上一个答案"
        webView.scrollView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter()
        footer.setTitle("", for: .idle)
        footer.setTitle("查看下一个答案", for: .pulling)
        footer.setTitle("加载中", for: .refreshing)
        footer.isHidden = true
        webView.scrollView.mj_footer = footer
        
        return webView
    }()
    
    let headerView: QuestionHeaderView = {
        let headerView = QuestionHeaderView()
        headerView.frame = CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 150)
        return headerView
    }()
    
    let loadingView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage.init(named: "ZHModuleDB.bundle/ZHDB_Discover_People_Loading")
        imgView.backgroundColor = BGColor
        return imgView
    }()
    
    var answerIdList: [String]?
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "问题详情"
        view.backgroundColor = BGColor
        
        view.addSubview(headerView)
        
        view.addSubview(webView)
        webView.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(8)
        })
        webView.scrollView.mj_header.refreshingBlock = { [weak self] in
            self?.loadHeader()
        }
        webView.scrollView.mj_footer.refreshingBlock = { [weak self] in
            self?.loadFooter()
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.height.equalTo(ScreenWidth)
        }
        
        self.answerIdList = [self.answerId!]
        QuestionProvider.request(.detail(answerId!)) { result in
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
    
    func loadHeader() {
        if self.index > 0 {
            self.index -= 1
            self.answerId = self.answerIdList?[self.index]
        } else {
            self.webView.scrollView.mj_header.endRefreshing()
        }
        if self.index == 0 {
            self.headerView.isHidden = false
            self.webView.snp.remakeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(self.headerView.snp.bottom).offset(8)
            })
        }
    }
    
    func loadFooter() {
        self.index += 1
        if self.index < self.answerIdList?.count ?? 1 {
            self.answerId = self.answerIdList?[self.index]
        } else {
            self.index = (self.answerIdList?.count ?? 1) - 1
            self.webView.scrollView.mj_footer.endRefreshingWithNoMoreData()
        }
        if self.index > 0 {
            self.headerView.isHidden = true
            self.webView.snp.remakeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(NavigationBarHeight)
            })
        }
    }
}


extension ZHAnswerDetailVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.removeFromSuperview()
        self.webView.scrollView.mj_footer.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingView.removeFromSuperview()
        self.webView.scrollView.mj_footer.isHidden = false
    }
}
