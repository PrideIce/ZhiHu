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

class ZHRecommendVC: ZHViewController {
    
    var recommendModelList:[RecommendModel]?

    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ZHHomeBaseCell.self, forCellReuseIdentifier: "cell")
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        refreshDataSource()
    }
    
    func refreshDataSource() {
        //首页接口请求
        ZHRecommendProvider.request(.recommendList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                //print(json)
                if let mappedObject = JSONDeserializer<RecommendModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                    self.recommendModelList = mappedObject as? [RecommendModel]
                    self.tableView.reloadData()
                }
//                self.updataBlock?()
            }
        }
    }
}

extension ZHRecommendVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommendModelList?.count ?? 0
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZHHomeBaseCell
        let model = self.recommendModelList?[indexPath.row]
        cell.titleLabel.text = model?.common_card?.feed_content?.title?.panel_text
        cell.contentLabel.text = model?.common_card?.feed_content?.content?.panel_text
        cell.footerLabel.text = model?.common_card?.footline?.elements?[0].text?.panel_text
        return cell
    }

}
