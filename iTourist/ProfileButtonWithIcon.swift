//
//  Profile.swift
//  iTourist
//
//  Created by Yaroslav Luchyt on 8/20/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

@IBDesignable class ProfileButtonWithIcon: RoundButton {

    override func draw(_ rect: CGRect) {
        printProfileImage(rect)
    }

    func printProfileImage (_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(6)
        context?.setStrokeColor(UIColor.blue.cgColor)
        let height = self.bounds.height
        let width = self.bounds.width
        let boundLength = min(height, width)
        var initialHeight = CGFloat(0)
        var initialWidth = CGFloat(0)
        
        if height > width {
            initialHeight = (height - width) / 2
        }
        if width > height {
            initialWidth = (width - height) / 2
        }
        
        context?.move(to: .init(x: initialWidth + 3, y: initialHeight + boundLength - 3))
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.28, y: initialHeight + boundLength * 0.64), control1: .init(x: initialWidth + 0, y: initialHeight + boundLength * 0.75), control2: .init(x: initialWidth + boundLength * 0.28, y: initialHeight + boundLength * 0.82))//shoulder
        context?.addLine(to: .init(x: initialWidth + boundLength * 0.225, y: initialHeight + boundLength * 0.47))
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.225, y: initialHeight + boundLength * 0.335), control1: .init(x: initialWidth + boundLength * 0.2, y: initialHeight + boundLength * 0.48), control2: .init(x: initialWidth + boundLength * 0.2, y: initialHeight + boundLength * 0.32))//ear
        context?.addLine(to: .init(x: initialWidth + boundLength * 0.225, y: initialHeight + boundLength * 0.23))
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.54, y: initialHeight + boundLength * 0.23), control1: .init(x: initialWidth + boundLength * 0.215, y: initialHeight + boundLength * 0.05), control2: .init(x: initialWidth + boundLength * 0.55, y: initialHeight + boundLength * 0.05))
        context?.addLine(to: .init(x: initialWidth + boundLength * 0.54, y: initialHeight + boundLength * 0.335))//head
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.54, y: initialHeight + boundLength * 0.47), control1: .init(x: initialWidth + boundLength * 0.565, y: initialHeight + boundLength * 0.32), control2: .init(x: initialWidth + boundLength * 0.565, y: initialHeight + boundLength * 0.48))//ear
        context?.addLine(to: .init(x: initialWidth + boundLength * 0.485, y: initialHeight + boundLength * 0.64))
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.77, y: initialHeight + boundLength - 3), control1: .init(x: initialWidth + boundLength * 0.485, y: initialHeight + boundLength * 0.82), control2: .init(x: initialWidth + boundLength * 0.77, y: initialHeight + boundLength * 0.75))//shoulder
        context?.move(to: .init(x: initialWidth + 0, y: initialHeight + boundLength - 3))
        context?.addLine(to: .init(x: initialWidth + boundLength - 3, y: initialHeight + boundLength - 3))//bottom line
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.75, y: initialHeight + boundLength * 0.71), control1: .init(x: initialWidth + boundLength, y: initialHeight + boundLength * 0.8), control2: .init(x: initialWidth + boundLength * 0.77, y: initialHeight + boundLength * 0.8))//girl's shoulder
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.85, y: initialHeight + boundLength * 0.4), control1: .init(x: initialWidth + boundLength * 1.1, y: initialHeight + boundLength * 0.71), control2: .init(x: initialWidth + boundLength * 0.9, y: initialHeight + boundLength * 0.7))//part of head :D
        context?.addCurve(to: .init(x: initialWidth + boundLength * 0.54, y: initialHeight + boundLength * 0.23), control1: .init(x: initialWidth + boundLength * 0.85, y: initialHeight + boundLength * 0.27), control2: .init(x: initialWidth + boundLength * 0.72, y: initialHeight + boundLength * 0.13))//head
        context?.move(to: .init(x: initialWidth + boundLength * 0.51, y: initialHeight + boundLength * 0.71))
        context?.addLine(to: .init(x: initialWidth + boundLength * 0.6, y: initialHeight + boundLength * 0.71))
        context?.addQuadCurve(to: .init(x: initialWidth + boundLength * 0.55, y: initialHeight + boundLength * 0.75), control: .init(x: initialWidth + boundLength * 0.6, y: initialHeight + boundLength * 0.75))//thing in center
        context?.strokePath()
        
    }

}
