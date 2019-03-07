//
//  HomeRecommendImageCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/14.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

class HomeRecommendImageCell: ZHHomeBaseCell {

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
        contentLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-120)
        }
        
        contentView.addSubview(zhImageView)
        zhImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var model: RecommendModel? {
        didSet {
            let content = (model?.common_card?.feed_content ?? Feed_content())!
            let url = URL.init(string: (content.image?.image_url)!)
            print("head:" + (content.image?.image_url)!)
            if (content.image?.image_url)! == "" {
                print("空")
            }
            self.zhImageView.kf.setImage(with: url)
        }
    }
}
