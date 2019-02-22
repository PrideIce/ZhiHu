//
//  Refresh+Ex.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/13.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import MJRefresh

extension UIScrollView {
    open func initRefreshView() {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        self.mj_header = header
        
        let footer = MJRefreshBackNormalFooter()
        footer.stateLabel.isHidden = true
        self.mj_footer = footer
    }
}
