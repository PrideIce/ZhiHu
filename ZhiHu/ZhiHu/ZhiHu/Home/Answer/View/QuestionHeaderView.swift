//
//  QuestionHeaderView.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/21.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import SnapKit
import UIKit

enum QuestionHeaderStyle {
    case list
    case detail
}

class QuestionHeaderView: UIView {
    typealias HeaderViewBlock = (Int) -> Void
    var actionBlock: HeaderViewBlock?

    var style: QuestionHeaderStyle = .detail {
        didSet {
            if style == .detail {
                inviteBtn.setTitleColor(ThemeColorBlue, for: .normal)
                inviteBtn.tintColor = ThemeColorBlue
                profileBtn.setTitle("查看全部答案", for: .normal)
                let image = UIImage(named: "ZHModuleQA.bundle/Night_Answer_Meta_CardIndicator")?.withRenderingMode(.alwaysTemplate)
                profileBtn.setImage(image, for: .normal)
                answerBtn.setTitleColor(ThemeColorBlue, for: .normal)
                answerBtn.tintColor = ThemeColorBlue
                focusBtn.isHidden = true
            } else {
                inviteBtn.setTitleColor(UIColor(hex: 0x666666), for: .normal)
                inviteBtn.tintColor = UIColor(hex: 0x666666)
                profileBtn.setTitle("1245人关注  80条评论", for: .normal)
                profileBtn.setImage(nil, for: .normal)
                answerBtn.setTitleColor(UIColor(hex: 0x666666), for: .normal)
                answerBtn.tintColor = UIColor(hex: 0x666666)
                focusBtn.isHidden = false
            }
        }
    }

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    var profileBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("查看全部答案", for: .normal)
        button.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = UIColor(hex: 0xCCCCCC)
        let image = UIImage(named: "ZHModuleQA.bundle/Night_Answer_Meta_CardIndicator")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(seeAllAnswers), for: .touchUpInside)
        return button
    }()

    var focusBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" 关注问题", for: .normal)
        button.backgroundColor = ThemeColorBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        let image = UIImage(named: "ZHModuleDB.bundle/ZH_icon_24px_add")
        button.setImage(image, for: .normal)
        button.isHidden = true
        return button
    }()

    var inviteBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" 邀请回答", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(ThemeColorBlue, for: .normal)
        button.tintColor = ThemeColorBlue
        let image = UIImage(named: "ZHModuleQA.bundle/ZHQuestion_vc_Invite_Normal")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()

    var answerBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" 写回答", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(ThemeColorBlue, for: .normal)
        button.tintColor = ThemeColorBlue
        let image = UIImage(named: "ZHModuleQA.bundle/Night_ZHAPP_Ask_Post")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()

    var horLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hex: 0xCCCCCC)
        return line
    }()

    var middleLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-12)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        addSubview(profileBtn)
        profileBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-50)
        }

        addSubview(focusBtn)
        focusBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(profileBtn)
            make.width.equalTo(85)
            make.height.equalTo(26)
        }

        addSubview(inviteBtn)
        inviteBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth / 2)
            make.height.equalTo(40)
        }

        addSubview(answerBtn)
        answerBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth / 2)
            make.height.equalTo(40)
        }

        addSubview(horLine)
        horLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(inviteBtn)
            make.height.equalTo(0.5)
        }

        addSubview(middleLine)
        middleLine.snp.makeConstraints { make in
            make.left.equalTo(ScreenWidth / 2)
            make.top.equalTo(inviteBtn)
            make.height.equalTo(inviteBtn)
            make.width.equalTo(0.5)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func seeAllAnswers() {
        if style == .detail {
            actionBlock?(0)
        }
    }
}
