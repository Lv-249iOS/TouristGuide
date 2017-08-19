//
//  DashboardSettingIcon.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/18/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit
import CoreGraphics

class DashboardSettingIcon: RoundButton {
    
    func getCenterCoordinatesOfButton() -> CGPoint {
        return CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let cof1: CGFloat = 0.7
        let cof2: CGFloat = 0.6
        let xForBigGear = self.frame.width * cof1
        let yForBigGear = self.frame.height * cof2
        drawGear(x: xForBigGear, y: yForBigGear, width: 35.0 * cof1, height: 25*cof1, context: context, radiusBig: 38*cof1, radiusSmall: 5*cof1, smallLineWidth: 5*cof1)
        
        let cof3: CGFloat = 0.3
        let cof4: CGFloat = 0.4
        //let cof5: CGFloat = 0.5
        let xForSmallGear = self.frame.width * cof3
        let yForSmallGear = self.frame.height * cof4
        drawGear(x: xForSmallGear, y: yForSmallGear, width: 20, height: 14, context: context, radiusBig: 20, radiusSmall: 2, smallLineWidth: 1)
        
    }
    ///This function in using
    func rectangleDrawing(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, context: CGContext?) -> CGPath{
        let rect = CGRect(x: x + width, y: y-height/2, width: width , height: height)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat.init(1 )).cgPath
        context?.addPath(clipPath)
        context?.setFillColor(UIColor.black.cgColor)
        return clipPath
    }
    func drawGear(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, context: CGContext?, radiusBig: CGFloat, radiusSmall: CGFloat, smallLineWidth: CGFloat) {
         var transform = CGAffineTransform(translationX: 0, y: 0)
        let pathRectangle = rectangleDrawing(x: x, y: y, width: width, height: height, context: context)
        context?.addPath(pathRectangle)
        
        //Generating 8 teeth
        for var angle in stride(from: 0, to: 360, by: 45) {
            angle+=45
            transform = transform.translatedBy(x: x, y: y)
            transform = transform.rotated(by: CGFloat.init(CGFloat.pi*CGFloat.init(angle)/180))
            transform = transform.translatedBy(x: -x, y: -y)
            context?.addPath(pathRectangle.copy(using: &transform)!)
        }
        //Drawing teeth
        context?.setFillColor(UIColor.black.cgColor)
        context?.closePath()
        context?.fillPath()
        //Drawing circles
        drawCircle(center: CGPoint.init(x: x, y: y), radius: radiusBig, lineWidth: 45.0*0.7)
        drawCircle(center: CGPoint.init(x: x, y: y), radius: radiusSmall, lineWidth: smallLineWidth)
        
    }
    func drawCircle(center: CGPoint, radius: CGFloat, lineWidth: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        //you can change the line width
        shapeLayer.lineWidth = lineWidth
        self.layer.addSublayer(shapeLayer)
    }
}




//func transparentSubview(rect: CGRect) {
//    let background = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
//    // Set a semi-transparent, black background.
//    background.backgroundColor = UIColor.clear
//    background.alignmentRect(forFrame: rect)
//    // Create the initial layer from the view bounds.
//    let maskLayer = CAShapeLayer()
//    maskLayer.frame = background.bounds
//    maskLayer.fillColor = UIColor.black.cgColor
//    // Create the frame for the circle.
//    let radius: CGFloat = 50.0
//    let rect = CGRect(x: background.frame.midX - radius, y: background.frame.midY - radius, width: 2 * radius, height: 2 * radius)
//    // Create the path.
//    let path = UIBezierPath(rect: background.bounds)
//    maskLayer.fillRule = kCAFillRuleEvenOdd
//    // Append the circle to the path so that it is subtracted.
//    path.append(UIBezierPath(rect: rect))
//    maskLayer.path = path.cgPath
//    // Set the mask of the view.
//    background.layer.mask = maskLayer
//    // Add the view so it is visible.
//    self.addSubview(background)
//}

