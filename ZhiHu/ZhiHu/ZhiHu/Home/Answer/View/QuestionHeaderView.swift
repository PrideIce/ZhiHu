//
//  QuestionHeaderView.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/21.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import UIKit
import SnapKit

class QuestionHeaderView: UIView {

    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    var answers: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("查看全部答案", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = UIColor.init(hex: 0xCCCCCC)
        let image = UIImage.init(named: "ZHModuleQA.bundle/Night_Answer_Meta_CardIndicator")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()
    
    var inviteBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle(" 邀请回答", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor.init(hex: 0x0B92FF), for: .normal)
        button.tintColor = UIColor.init(hex: 0x0B92FF)
        let image = UIImage(named: "ZHModuleQA.bundle/ZHQuestion_vc_Invite_Normal")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()
    
    var answerBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle(" 写回答", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor.init(hex: 0x0B92FF), for: .normal)
        button.tintColor = UIColor.init(hex: 0x0B92FF)
        let image = UIImage(named: "ZHModuleQA.bundle/Night_ZHAPP_Ask_Post")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()
    
    var horLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hex: 0xCCCCCC)
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
        
        title.text = "你所见过的善良的开发设计的？"
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(25)
//            make.right.equalToSuperview().offset(10)
        }
        
        addSubview(answers)
        answers.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-50)
            //make.top.equalTo(title.snp.bottom).offset(30)
        }
        
        addSubview(inviteBtn)
        inviteBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/2)
            make.height.equalTo(40)
        }
        
        addSubview(answerBtn)
        answerBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/2)
            make.height.equalTo(40)
        }
        
        addSubview(horLine)
        horLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(inviteBtn)
            make.height.equalTo(0.5)
        }
        
        addSubview(middleLine)
        middleLine.snp.makeConstraints { (make) in
            make.left.equalTo(ScreenWidth/2)
            make.top.equalTo(inviteBtn)
            make.height.equalTo(inviteBtn)
            make.width.equalTo(0.5)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
