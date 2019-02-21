//
//  HotListCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/14.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

class HotListCell: UITableViewCell {

    // 标题
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight:UIFont.Weight.bold)
        label.numberOfLines = 0
        return label
    }()
    // 底部
    var footerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(150, 150, 150)
        return label
    }()
    // 图片
    var hotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(12)
            make.right.equalToSuperview().offset(-120)
        }
        
        contentView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(titleLabel).offset(0)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(hotImageView)
        hotImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(65)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
