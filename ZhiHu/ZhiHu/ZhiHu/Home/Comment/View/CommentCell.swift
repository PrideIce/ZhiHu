//
//  CommentCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/8.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import Kingfisher

class CommentCell: UITableViewCell {

    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seeReplysBtn: UIButton!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    
    var model: CommentModel? {
        didSet {
            let url = URL(string: model?.author?.member?.avatar_url ?? "")
            headImgView.kf.setImage(with: url, placeholder: UIImage(named: "UserGuestCenterBundle.bundle/Avatar_Liukanshan_Normal"))
            nameLabel.text = model?.author?.member?.name
            contentLabel.text = model?.content
            upBtn.setTitle("\(model?.vote_count ?? 0) ", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        self.headImgView.layer.masksToBounds = true
        self.headImgView.layer.cornerRadius = 15
        
        let replyImage = UIImage(named: "ZHModuleDB.bundle/ZHDB_Badge_Comment")?.withRenderingMode(.alwaysTemplate)
        replyBtn.setImage(replyImage, for: .normal)
        let upImage = UIImage(named: "ZHModuleDB.bundle/ZHDB_Badge_Comment_Like")?.withRenderingMode(.alwaysTemplate)
        upBtn.setImage(upImage, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func menuClick(_ sender: Any) {
    }
    
    @IBAction func seeReplysClick(_ sender: Any) {
    }
    
    @IBAction func upClick(_ sender: Any) {
    }
    
    @IBAction func commentClick(_ sender: Any) {
    }
}
