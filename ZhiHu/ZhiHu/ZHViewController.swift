//
//  ZHViewController.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/9.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

class ZHViewController: UIViewController {
    
    var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "UserGuestCenterBundle.bundle/ZHProfile_BackArrow_Active_Black")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()
    
    var menuBtn: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "ZHModuleDB.bundle/More_Normal")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .gray
    
        backBtn.addTarget(self, action: #selector(backAction(button:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = item1
        
        let item2 = UIBarButtonItem(customView: menuBtn)
        navigationItem.rightBarButtonItem = item2
    }
    
    @objc func backAction(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
