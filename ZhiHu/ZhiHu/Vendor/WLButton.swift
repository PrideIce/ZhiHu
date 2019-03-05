//
//  WLButton.swift
//  SuspendButton
//
//  Created by 王垒 on 2017/12/4.
//  Copyright © 2017年 王垒. All rights reserved.
//
import UIKit

// The width of the screen
let WLWindowWidth = UIScreen.main.bounds.size.width

// The screen height
let WLWindowHeight = UIScreen.main.bounds.size.height

class WLButton: UIButton {
    var moveEnable: Bool!

    var moveEnabled: Bool!

    var beginPoint: CGPoint?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        moveEnabled = false

        if !moveEnable {
            return
        }

        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch

            beginPoint = t.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveEnabled = true

        if !moveEnable {
            return
        }

        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch

            let currentPosition: CGPoint = t.location(in: self)

            // 偏移量
            // The offset
            let offsetX: CGFloat = currentPosition.x - (beginPoint?.x)!

            let offsetY: CGFloat = currentPosition.y - (beginPoint?.y)!

            // 移动后的中心坐标
            // move after the center coordinates
            center = CGPoint(x: center.x + offsetX, y: center.y + offsetY)

            // x轴左右极限坐标
            // limit around the x axis
            if center.x > (superview?.frame.size.width)! - frame.size.width / 2 {
                let x: CGFloat = (superview?.frame.size.width)! - frame.size.width / 2

                center = CGPoint(x: x, y: center.y + offsetY)
            } else if center.x < frame.size.width / 2 {
                let x: CGFloat = frame.size.width / 2

                center = CGPoint(x: x, y: center.y + offsetY)
            }

            // y轴上下极限坐标
            // limit up and down the y axis
            if center.y > (superview?.frame.size.height)! - frame.size.height / 2 {
                let x: CGFloat = center.x

                let y: CGFloat = center.y

                center = CGPoint(x: x, y: y)
            } else if center.y <= frame.size.height / 2 {
                let x: CGFloat = center.x

                let y: CGFloat = frame.size.height / 2

                center = CGPoint(x: x, y: y)
            }
        }
        
        setTitle("", for: .normal)
        self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: 40, height: 40)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moveEnable {
            return
        }
        
        let width = self.frame.size.width
        let height = self.frame.size.height
        if center.x >= (superview?.frame.size.width)! / 2 {
            // 需向右侧移动
            // Need to move to the right

            // 偏移动画
            // Offset animation
            UIView.beginAnimations("move", context: nil)

            UIView.setAnimationDuration(0.3)

            UIView.setAnimationDelegate(self)

            frame = CGRect(x: WLWindowWidth - width - 15, y: center.y - 20, width: width, height: height)

            // 提交UIView动画
            // Submit a UIView animation
            UIView.commitAnimations()
        } else {
            // 需向左侧移动
            // Need to move to the left

            // 偏移动画
            // Offset animation
            UIView.beginAnimations("move", context: nil)

            UIView.setAnimationDuration(0.3)

            UIView.setAnimationDelegate(self)

            frame = CGRect(x: 15, y: center.y - 20, width: width, height: height)

            // 提交UIView动画
            // Submit a UIView animation
            UIView.commitAnimations()
        }

        super.touchesEnded(touches, with: event)
    }

    // 外界因素取消touch事件，如进入电话
    // to cancel the touch events external factors, such as into the phone
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
