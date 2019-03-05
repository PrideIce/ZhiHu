//
//  ZHHotVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/13.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import Alamofire
import MJRefresh

class ZHHotVC: ZHBaseVC {

    var recommendModelList:[HotListModel]?
    var pageIndex:Int = 0
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HotListCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        tableView.initRefreshView()
        tableView.mj_header.refreshingBlock = { [weak self] in
            self?.pageIndex = 0
            self?.refreshDataSource()
        }
        tableView.mj_footer.refreshingBlock = { [weak self] in
            self?.refreshDataSource()
        }
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshDataSource() {
        //首页接口请求
        ZHRecommendProvider.request(.hotList(self.pageIndex)) { result in
            if case let .success(response) = result {
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                //print(json)
                if let mappedObject = JSONDeserializer<HotListModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                    if (self.pageIndex == 0) {
                        self.recommendModelList = mappedObject as? [HotListModel]
                    } else {
                        let nextPage = mappedObject as? [HotListModel]
                        self.recommendModelList? += nextPage!
                    }
                    self.pageIndex += 1
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ZHHotVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommendModelList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HotListCell
        let model = self.recommendModelList?[indexPath.row]
        cell.titleLabel.text = model?.target?.title_area?.text
        let url = URL(string: (model?.target?.image_area?.url)!)
        cell.hotImageView.kf.setImage(with: url)
        cell.footerLabel.text = model?.target?.metrics_area?.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.recommendModelList?[indexPath.row]
        let questionId = model?.card_id?.dropFirst(2)
        let vc = ZHQuestionVC()
        vc.questionId = String(questionId!)
        vc.questionTitle = model?.target?.title_area?.text ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

