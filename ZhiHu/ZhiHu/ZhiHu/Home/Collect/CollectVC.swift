//
//  CollectVC.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/8.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SwiftMessages

class CollectVC: ZHBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    var collectFoldList = [["name":"事业", "count": "35"],
                           ["name":"生活", "count": "48"],
                           ["name":"编程", "count": "30"],
                           ["name":"交易", "count": "9"]]
    
    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCollectFoldClick(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib.init(nibName: "CollectFoldCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CollectFoldCellID)
    }
}

extension CollectVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.collectFoldList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
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
        let model = self.collectFoldList[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectFoldCellID, for: indexPath) as! CollectFoldCell
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
