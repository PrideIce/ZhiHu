//
//  ZHRecommendVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/10.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import Alamofire
import MJRefresh

class ZHRecommendVC: ZHViewController {
    
    let ZHHomeBaseCellID = "ZHHomeBaseCell"
    let HomeRecommendImageCellID = "HomeRecommendImageCell"
    let HomeRecommendBigImageCellID = "HomeRecommendBigImageCell"
    let HomeListVideoCellID = "HomeListVideoCell"
    
    var recommendModelList:[RecommendModel]?
    var pageIndex:Int = 0

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ZHHomeBaseCell.self, forCellReuseIdentifier: ZHHomeBaseCellID)
        tableView.register(HomeRecommendImageCell.self, forCellReuseIdentifier: HomeRecommendImageCellID)
        tableView.register(HomeRecommendBigImageCell.self, forCellReuseIdentifier: HomeRecommendBigImageCellID)
        tableView.register(HomeListVideoCell.self, forCellReuseIdentifier: HomeListVideoCellID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
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
        ZHRecommendProvider.request(.recommendList(self.pageIndex)) { result in
            if case let .success(response) = result {
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                //print(json)
                if let mappedObject = JSONDeserializer<RecommendModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                    //去掉广告
                    var noAdList:[RecommendModel] = [];
                    for model in (mappedObject as! [RecommendModel]) {
                        if model.common_card != nil || model.fields != nil {
                            noAdList.append(model)
                        }
                    }
                    if (self.pageIndex == 0) {
                        self.recommendModelList = noAdList
                    } else {
                        self.recommendModelList? += noAdList
                    }
                    self.pageIndex += 1
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ZHRecommendVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.recommendModelList?.count ?? 0
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
        let model = self.recommendModelList?[indexPath.section]
        if model?.common_card != nil {
            let cell:ZHHomeBaseCell
            let content = (model?.common_card?.feed_content ?? Feed_content())!
            if content.image != nil {
                cell = tableView.dequeueReusableCell(withIdentifier: HomeRecommendImageCellID, for: indexPath) as! HomeRecommendImageCell
            } else if content.video != nil {
                cell = tableView.dequeueReusableCell(withIdentifier: HomeListVideoCellID, for: indexPath) as! HomeListVideoCell
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: ZHHomeBaseCellID, for: indexPath) as! ZHHomeBaseCell
            }
            cell.model = model
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecommendBigImageCellID, for: indexPath) as! HomeRecommendBigImageCell
            cell.model = model
            return cell

        }
    }

}
