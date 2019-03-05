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
    let QuestionBaseCellID = "QuestionBaseCellID"
    
    var offset: Int = 0
    var questionId: String = ""
    var questionTitle: String = ""
    var answerList: [ZHAnswer] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuestionBaseCell.self, forCellReuseIdentifier: QuestionBaseCellID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    let headerView: QuestionHeaderView = {
        let headerView = QuestionHeaderView()
        headerView.style = .list
        headerView.frame = CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 150)
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "所有答案"
        view.backgroundColor = BGColor

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        tableView.initRefreshView()
        tableView.mj_header.refreshingBlock = { [weak self] in
            self?.offset = 0
            self?.refreshDataSource()
        }
        tableView.mj_footer.refreshingBlock = { [weak self] in
            self?.refreshDataSource()
        }
        tableView.mj_header.beginRefreshing()
        
        headerView.titleLabel.text = questionTitle
    }
    
    func refreshDataSource() {
        QuestionProvider.request(.list(questionId, offset)) { result in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<ZHAnswer>.deserializeModelArrayFrom(json: json["data"].description) {
                    if self.offset == 0 {
                        self.answerList = mappedObject as! [ZHAnswer]
                    } else {
                        self.answerList += mappedObject as! [ZHAnswer]
                    }
                    self.offset += 1
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ZHQuestionVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return answerList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = answerList[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionBaseCellID, for: indexPath) as! QuestionBaseCell
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = answerList[indexPath.section]
        let vc = ZHAnswerDetailVC()
        vc.answerId = model.id ?? ""
        vc.questionTitle = questionTitle
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

