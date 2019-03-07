//
//  QuestionBaseCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/4.
//  Copyright © 2019 陈逸辰. All rights reserved.
//  QuestionBaseCell

import UIKit
import HandyJSON
import Moya
import SwiftyJSON
import Kingfisher

class QuestionBaseCell: UITableViewCell {
    // 头像
    var headImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 9
        return imageView
    }()
    
    // 名字
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // 内容
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGBColor(60, 60, 60)
        label.numberOfLines = 3
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    // 底部
    var footerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = RGBColor(150, 150, 150)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(15)
            make.width.height.equalTo(18)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headImgView)
            make.left.equalTo(headImgView.snp.right).offset(6)
        }
        nameLabel.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(headImgView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-35)
        }
        
        contentView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints { make in
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
    
    var model: ZHAnswer? {
        didSet {
            guard let model = model else { return }
            let url = URL(string: model.author?.avatar_url ?? "")
            headImgView.kf.setImage(with: url, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
            nameLabel.text = model.author?.name
            contentLabel.text = model.excerpt
            let up = model.voteup_count
            let thanks = model.thanks_count
            let comment = model.comment_count
            footerLabel.text = "\(up) 赞同 · \(thanks) 感谢 · \(comment) 评论 · 10小时前"
        }
    }
}
