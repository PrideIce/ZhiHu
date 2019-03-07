//
//  ZHHomeController.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/9.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import DNSPageView
import UIKit


class ZHHomeController: ZHBaseVC {
    let titles = ["关注", "推荐", "热榜", "视频"]
    let viewControllers = [UIViewController(), ZHRecommendVC(), ZHHotVC(), UIViewController()]
    
    lazy var pageView: DNSPageView = {
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.black
        style.bottomLineHeight = 2
        
        let frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight - 44)
        let pageView = DNSPageView(frame: frame,
                                   style: style,
                                   titles: titles,
                                   childViewControllers: viewControllers,
                                   startIndex: 1)
        return pageView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField.init(frame: CGRect(x: 15, y: StatusBarHeight + 10, width: ScreenWidth - 100, height: 30))
        textField.placeholder = "超一亿人朋友圈仅3天可见"
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.textAlignment = NSTextAlignment.center
        textField.backgroundColor = RGBColor(240, 240, 240)
        textField.delegate = self
        return textField
    }()
    
    lazy var questionBtn: UIButton = {
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth - 85, y: StatusBarHeight + 10, width: 80, height: 30)
        questionBtn.setTitle("提问", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "ZHModuleColumnImage.bundle/Night_ZHAPP_Ask_Post"), for: UIControlState.normal)
        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
        return questionBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 搜索栏
        initSearchBar()

        for vc in viewControllers {
            addChildViewController(vc)
        }
        view.addSubview(pageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func initSearchBar() {
        view.addSubview(searchTextField)
        view.addSubview(questionBtn)
    }
}

extension ZHHomeController {
}

extension ZHHomeController {
    @objc func questionAction(button: UIButton) {
    }
}

extension ZHHomeController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = ZHHomeSearchVC()
        navigationController?.pushViewController(vc, animated: false)
        return false
    }
}
