//
//  HomeListVideoCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/14.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

class HomeListVideoCell: ZHHomeBaseCell {
    
    override var model: RecommendModel? {
        didSet {
            let title = model?.common_card?.feed_content?.title?.panel_text
            self.titleLabel.text = "Video: " + title!
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

}
