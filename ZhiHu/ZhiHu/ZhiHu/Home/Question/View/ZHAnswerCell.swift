//
//  ZHAnswerCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/22.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import WebKit

class ZHAnswerCell: UITableViewCell {

    var webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
