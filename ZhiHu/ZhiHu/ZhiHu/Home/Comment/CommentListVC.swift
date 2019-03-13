//
//  CommentListVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/8.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

let CommentCellID = "CommentCellID"

class CommentListVC: ZHBaseVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var commentsCount: Int = 0
    var commentList: [CommentModel] = []
    var offset: Int = 0
    var answerId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib.init(nibName: "CommentCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CommentCellID)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.initRefreshView()
        tableView.mj_header.refreshingBlock = { [weak self] in
            self?.offset = 0
            self?.refreshDataSource()
        }
        tableView.mj_footer.refreshingBlock = { [weak self] in
            self?.offset += 10
            self?.refreshDataSource()
        }
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshDataSource() {
        AnswerProvider.request(.commentList(answerId, offset))  { result in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                //print(json)
                
                if let object = JSONDeserializer<CommentListModel>.deserializeFrom(json: json.description) {
                    self.commentsCount = object.common_counts
                    self.titleLabel.text = "全部 \(self.commentsCount) 条评论"
                    
                    if self.offset == 0 {
                        self.commentList = object.data ?? []
                    } else {
                        self.commentList += object.data ?? []
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CommentListVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.commentList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
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
        let model = self.commentList[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCellID, for: indexPath) as! CommentCell
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = answerList[indexPath.section]
//        let vc = ZHAnswerDetailVC()
//        vc.answerId = model.id ?? ""
//        vc.questionTitle = questionTitle
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
    }
}
