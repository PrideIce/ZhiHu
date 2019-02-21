//
//  ZHHomeController.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/9.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import DNSPageView
import UIKit

class ZHHomeController: ZHViewController {
    let barHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 搜索栏
        initSearchBar()

        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.black
        style.bottomLineHeight = 2

        let titles = ["关注", "推荐", "热榜", "视频"]
        let viewControllers: [UIViewController] = [UIViewController(), ZHRecommendVC(), ZHHotVC(), UIViewController()]
        for vc in viewControllers {
            addChildViewController(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: statusBarHeight + 10 + barHeight, width: ScreenWidth, height: ScreenHeigth - navigationBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers, startIndex: 1)
        view.addSubview(pageView)
    }

    func initSearchBar() {
        let textField = UITextField.init(frame: CGRect(x: 15, y: statusBarHeight + 10, width: ScreenWidth - 100, height: barHeight))
        
        textField.placeholder = "超一亿人朋友圈仅3天可见"
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.textAlignment = NSTextAlignment.center
        textField.backgroundColor = UIColor(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0, alpha: 1)
        textField.delegate = self
        view.addSubview(textField)
        
        let questionBtn = UIButton.init(type: UIButtonType.system)
        questionBtn.frame = CGRect(x: ScreenWidth - 85, y: statusBarHeight + 10, width: 80, height: barHeight)
        questionBtn.setTitle("提问", for: UIControlState.normal)
        questionBtn.setImage(UIImage(named: "ZHModuleColumnImage.bundle/Night_ZHAPP_Ask_Post"), for: UIControlState.normal)
        questionBtn.blueTheme()
        questionBtn.addTarget(self, action: #selector(questionAction(button:)), for: UIControlEvents.touchUpInside)
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
