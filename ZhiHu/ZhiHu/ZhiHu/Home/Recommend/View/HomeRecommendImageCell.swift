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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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

}
