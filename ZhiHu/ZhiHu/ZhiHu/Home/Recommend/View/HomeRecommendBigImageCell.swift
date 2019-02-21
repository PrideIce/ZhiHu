//
//  HomeRecommendBigImageCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/14.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

class HomeRecommendBigImageCell: ZHHomeBaseCell {
    
    // 图片
    var zhImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(zhImageView)
        zhImageView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.height.equalTo(120)
        }
        
        contentLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(zhImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-35)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var model: RecommendModel? {
        didSet {
            let market = (model?.fields ?? MarketCard())!
            self.titleLabel.text = market.body?.title ?? ""
            self.contentLabel.text = market.body?.description
            self.footerLabel.text = "立即参与"
            self.headImgView.kf.setImage(with: URL(string: (market.header?.image)!))
            self.nameLabel.text = market.header?.text
            let url = URL.init(string: (market.body?.image)!)
            self.zhImageView.kf.setImage(with: url)
        }
    }
}
