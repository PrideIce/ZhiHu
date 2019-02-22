//
//  QuestionDetailVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/21.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class AnswerDetailVC: ZHViewController {
    
    var answerUrl: String? {
        didSet {
            let strArray = answerUrl?.split(separator: "/")
            self.answerId = String(strArray?.last ?? "")
        }
    }
    var answerId: String = ""
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.grouped)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "问题详情"
        
        view.backgroundColor = .gray
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        tableView.tableHeaderView = QuestionHeaderView.init(frame: CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: 150))
        
        tableView.initRefreshView()
        tableView.mj_header.refreshingBlock = { [weak self] in
            self?.answerId = ""
            self?.getFisrtAnswer()
        }
        tableView.mj_footer.refreshingBlock = { [weak self] in
            self?.getNextAnswer()
        }
        tableView.mj_header.beginRefreshing()

        AnswerProvider.request(.detail(self.answerUrl!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                print(json)
                
                if let mappedObject = JSONDeserializer<ZHFirstAnswer>.deserializeFrom(json: json.description) {
                    print("1")
                }
            }
        }
    }
    
    func getFisrtAnswer() {
        
    }
    
    func getNextAnswer() {
        
    }


}
