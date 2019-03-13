//
//  ZHAnswerDetailVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/27.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import HandyJSON
import MJRefresh
import Moya
import SnapKit
import SwiftMessages
import SwiftyJSON
import UIKit
import WebKit

class ZHAnswerDetailVC: ZHBaseVC {
    var questionTitle: String = ""
    var questionId: String = ""
    var answerIdList: [String]?
    var index: Int = 0

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
        headerView.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 150)
        return headerView
    }()

    let loadingView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "ZHModuleDB.bundle/ZHDB_Discover_People_Loading")
        imgView.backgroundColor = BGColor
        return imgView
    }()

    let nextBtn: WLButton = {
        let button = WLButton()
        button.setTitle(" 下一个回答", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "ZHModuleQA.bundle/ZHAnswer_next_arrow"), for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: 0xEEEEEE).cgColor
        button.addTarget(self, action: #selector(nextAnswer), for: .touchUpInside)
        button.moveEnable = true
        return button
    }()

    let searchField: UITextField = {
        let field = UITextField()
        field.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        field.placeholder = "搜索知乎内容"
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: 14)
        field.borderStyle = .roundedRect
        field.backgroundColor = BGColor
        return field
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    //透明的模拟收藏按钮
    let collectBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(collectClick), for: .touchUpInside)
        return button
    }()
    
    //透明的模拟评论按钮
    let commentBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(commentClick), for: .touchUpInside)
        return button
    }()
    
    static func demoCentered() {
        let view = MessageView.viewFromNib(layout: .tabView)
        view.configureDropShadow()
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        view.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        //Disable the interactive pan-to-hide gesture.
        config.interactiveHide = false
        config.eventListeners.append() { event in
            if case .didHide = event { print("yep") }
        }
        SwiftMessages.show(config: config, view: view)
    }
    
    @objc func allAnswersClick() {
        let vc = ZHQuestionVC()
        vc.questionId = self.questionId
        vc.questionTitle = self.questionTitle
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func commentClick() {
        let vc = CommentListVC()
        vc.answerId = answerId ?? ""
        vc.preferredContentSize.height = ScreenHeight - StatusBarHeight
        vc.view.layer.masksToBounds = true
        vc.view.layer.cornerRadius = 10
        
        let segue = SwiftMessagesSegue(identifier: nil, source: self, destination: vc)
        segue.configure(layout: .bottomMessage)
        prepare(for: segue, sender: nil)
        segue.perform()
    }
    
    @objc func collectClick() {
        let vc = CollectVC()
        vc.preferredContentSize.height = 400
        vc.view.layer.masksToBounds = true
        vc.view.layer.cornerRadius = 10
        
        let segue = SwiftMessagesSegue(identifier: nil, source: self, destination: vc)
        segue.configure(layout: .bottomMessage)
        prepare(for: segue, sender: nil)
        segue.perform()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.titleView = searchField
        view.backgroundColor = BGColor

        headerView.titleLabel.text = questionTitle
        titleLabel.text = questionTitle
        view.addSubview(headerView)
        headerView.actionBlock = { [unowned self] (btnIndex: Int) in
            if btnIndex == 0 {
                self.allAnswersClick()
            } else if btnIndex == 1 {
                self.collectClick()
            } else if btnIndex == 2 {
                self.commentClick()
            }
        }

        view.addSubview(webView)
        webView.snp.makeConstraints({ make in
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
        loadingView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.height.equalTo(ScreenWidth)
        }

        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(110)
            make.height.equalTo(40)
        }
        
        view.addSubview(collectBtn)
        collectBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-SafeBottomHeight - 5)
            make.width.height.equalTo(40)
            make.right.equalToSuperview().offset(-75)
        }
        
        view.addSubview(commentBtn)
        commentBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-SafeBottomHeight - 5)
            make.width.equalTo(55)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }

        answerIdList = [self.answerId!]
        AnswerProvider.request(.detail(answerId!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // print(json)

                if let mappedObject = JSONDeserializer<ZHFirstAnswer>.deserializeFrom(json: json.description) {
                    self.answerIdList? += mappedObject.pagination_info?.next_answer_ids ?? []
                    // print(self.answerIdList!)
                }
            }
        }

        AnswerProvider.request(.question(answerId!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print(json)

                if let mappedObject = JSONDeserializer<ZHQuestion>.deserializeFrom(json: json.description) {
                    self.questionId = mappedObject.id ?? ""
                }
            }
        }
    }

    func loadHeader() {
        if index > 0 {
            index -= 1
            answerId = answerIdList?[self.index]
        } else {
            webView.scrollView.mj_header.endRefreshing()
        }
        if index == 0 {
            headerView.isHidden = false
            webView.snp.remakeConstraints({ make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(self.headerView.snp.bottom).offset(8)
            })
        }
    }

    func loadFooter() {
        index += 1
        if index < answerIdList?.count ?? 1 {
            answerId = answerIdList?[self.index]
        } else {
            index = (answerIdList?.count ?? 1) - 1
            webView.scrollView.mj_footer.endRefreshingWithNoMoreData()
        }
        if index > 0 {
            headerView.isHidden = true
            webView.snp.remakeConstraints({ make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(NavigationBarHeight)
            })
        }
    }

    @objc func nextAnswer() {
        webView.scrollView.delegate = nil
        webView.scrollView.mj_footer.beginRefreshing()
    }
}

extension ZHAnswerDetailVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.removeFromSuperview()
        self.webView.scrollView.mj_footer.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.webView.scrollView.delegate = self
        })
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingView.removeFromSuperview()
        self.webView.scrollView.mj_footer.isHidden = false
    }
}

extension ZHAnswerDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
            searchField.alpha = 0
            if titleLabel.alpha == 0 {
                navigationItem.titleView = titleLabel
                UIView.animate(withDuration: 1) {
                    self.titleLabel.alpha = 1
                }
            }
        } else {
            titleLabel.alpha = 0
            if searchField.alpha == 0 {
                navigationItem.titleView = searchField
                UIView.animate(withDuration: 0.5) {
                    self.searchField.alpha = 1
                }
            }
        }
    }
}
