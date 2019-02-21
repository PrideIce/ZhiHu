//
//  ZHHomeBaseCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/10.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import Moya

class ZHHomeBaseCell: UITableViewCell {
    
    var token : String? {
        didSet {
            //头像等信息请求
            ZHRecommendProvider.request(.memberProfile(token!)) { result in
                if case let .success(response) = result {
                    //解析数据
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    
                    //print(json)
                    if let member = JSONDeserializer<ZHMember>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                        self.nameLabel.text = member.name
                        self.profileLabel.text = member.headline!
                        let url = URL(string: member.avatar_url!)
                        self.headImgView.kf.setImage(with: url)
                    }
                }
            }
        }
    }
    // 标题
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    // 内容
    var contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(80, 80, 80)
        label.numberOfLines = 3
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    // 头像
    var headImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 9
        return imageView
    }()
    // 名字
    var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    // 签名
    var profileLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: 0xAAAAAA)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    // 底部
    var footerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(150, 150, 150)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(12)
            make.right.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)
            make.width.height.equalTo(18)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headImgView)
            make.left.equalTo(headImgView.snp.right).offset(6)
        }
        nameLabel.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        
        contentView.addSubview(profileLabel)
        profileLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headImgView)
            make.left.equalTo(nameLabel.snp.right).offset(6)
            make.right.equalToSuperview().offset(-10)
        }
        //profileLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-35)
        }
        
        contentView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
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
