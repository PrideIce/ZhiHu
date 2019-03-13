//
//  CollectFoldCell.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/3/11.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit

let CollectFoldCellID = "CollectFoldCellID"

class CollectFoldCell: UITableViewCell {
    @IBOutlet var foldNameLabel: UILabel!
    @IBOutlet var contentNumberLabel: UILabel!
    @IBOutlet var selectBtn: UIButton!

    var model: [String: String] = ["name": "", "count": ""] {
        didSet {
            foldNameLabel.text = model["name"] ?? ""
            contentNumberLabel.text = (model["count"] ?? "") + "个内容"
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

    @IBAction func selectClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
