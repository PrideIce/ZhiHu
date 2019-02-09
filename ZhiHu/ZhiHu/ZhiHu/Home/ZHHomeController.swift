//
//  ZHHomeController.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/9.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import DNSPageView

class ZHHomeController: ZHViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.black
        style.bottomLineHeight = 2
        
        
        let titles = ["关注","推荐","热榜","视频"]
        let viewControllers:[UIViewController] = [UIViewController(),UIViewController(),UIViewController(),UIViewController()]
        for vc in viewControllers{
            self.addChildViewController(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: ScreenWidth, height: ScreenHeigth-navigationBarHeight-44), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
    }

}
