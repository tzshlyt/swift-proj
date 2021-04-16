//
//  CustomButton.swift
//  hitTest
//
//  Created by lan on 2021/3/17.
//

import UIKit

class CustomButton: UIButton {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("hitTest \(point)")
        if self.isUserInteractionEnabled == false || self.isHidden || self.alpha <= 0.01 {
            return nil
        }
        
        if self.point(inside: point, with: event) {
            for (_, view) in self.subviews.enumerated().reversed() {
                let convertPoint = self.convert(point, to: view)
                print("point \(point) converPoint \(convertPoint)")
                let hit = view.hitTest(convertPoint, with: event)
                if  hit != nil {
                    print("##### hit")
                    return hit  // 如果返回 self，self 处理事件
                }
            }
            return self
        } else {
            return nil
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let x1 = point.x
        let y1 = point.y
        
        let x2 = self.bounds.size.width / 2
        let y2 = self.bounds.size.height / 2
        
        let dis = sqrt(pow(x1-x2, 2) + pow(y1-y2, 2))
        if dis <= x2 {
            return true
        } else {
            return false
        }
    }
}
