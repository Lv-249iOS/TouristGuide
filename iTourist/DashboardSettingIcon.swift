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
        var transform = CGAffineTransform(translationX: 0, y: 0)
        //Center of button
        let x = self.bounds.midX
        let y = self.bounds.midY
        //Our Rectangle
        let pathRectangle = rectangleDrawing(x: x, y: y, width: CGFloat.init(35), height: CGFloat.init(25), context: context)
        context?.addPath(pathRectangle)
        
        for var angle in stride(from: 0, to: 360, by: 45) {
            angle+=45
            transform = transform.translatedBy(x: x, y: y)
            transform = transform.rotated(by: CGFloat.init(CGFloat.pi*CGFloat.init(angle)/180))
            transform = transform.translatedBy(x: -x, y: -y)
            context?.addPath(pathRectangle.copy(using: &transform)!)
        }
        //Drawing
        context?.setFillColor(UIColor.black.cgColor)
        context?.closePath()
        context?.fillPath()
        
       //transparentSubview(rect: (context?.path?.boundingBox)!)
        
        drawCircle(center: CGPoint.init(x: x, y: y), radius: CGFloat.init(35), lineWidth: 45.0)
        drawCircle(center: CGPoint.init(x: x, y: y), radius: CGFloat.init(5), lineWidth: 5)
        // transparentSubview()
        
        
    }
    ///This function in using
    func rectangleDrawing(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, context: CGContext?) -> CGPath{
        let rect = CGRect(x: x + width, y: y-height/2, width: width , height: height)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat.init(5)).cgPath
        context?.addPath(clipPath)
        context?.setFillColor(UIColor.black.cgColor)
        return clipPath
    }
    
   
    
    func transparentSubview(rect: CGRect) {
        
                //
                let background = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
                // Set a semi-transparent, black background.
                background.backgroundColor = UIColor.clear
                background.alignmentRect(forFrame: rect)
                // Create the initial layer from the view bounds.
                let maskLayer = CAShapeLayer()
                maskLayer.frame = background.bounds
                maskLayer.fillColor = UIColor.black.cgColor
        
                // Create the frame for the circle.
        
        
        
        
//                let radius: CGFloat = 50.0
//                let rect = CGRect(x: background.frame.midX - radius, y: background.frame.midY - radius, width: 2 * radius, height: 2 * radius)
        
        
        
        
                // Create the path.
                let path = UIBezierPath(rect: background.bounds)
                maskLayer.fillRule = kCAFillRuleEvenOdd

                // Append the circle to the path so that it is subtracted.
                path.append(UIBezierPath(rect: rect))
                maskLayer.path = path.cgPath
        
                // Set the mask of the view.
                background.layer.mask = maskLayer
        
                // Add the view so it is visible.
                self.addSubview(background)
    }
    
    
    func drawCircle(center: CGPoint, radius: CGFloat, lineWidth: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
        //circlePath.fill()
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeColor = UIColor.black.cgColor
        //you can change the line width
        shapeLayer.lineWidth = lineWidth
        
        
        self.layer.addSublayer(shapeLayer)
        
        
        
    }
    func drawRectangle(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        // Create the frame for the circle.
        let maskLayer = CAShapeLayer()
        maskLayer.frame = overlay.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        let rect = CGRect(x: getCenterCoordinatesOfButton().x, y: getCenterCoordinatesOfButton().y, width: CGFloat.init(120), height: CGFloat.init(15))
        
        let path = UIBezierPath(rect: overlay.bounds)
        maskLayer.fillRule = kCAFillRuleEvenOdd
        // Append the circle to the path so that it is subtracted.
        path.append(UIBezierPath(rect: rect))
        maskLayer.path = path.cgPath
        
        // Set the mask of the view.
        overlay.layer.mask = maskLayer
        
        // Add the view so it is visible.
        self.addSubview(overlay)
    }
}
























class DashboardSettingIcon_1: RoundButton {
    
    
    
    override func draw(_ rect: CGRect) {
        
    }
    
    
    
    
    
    //    func sector() {
    //        let circleCenter = getCoordinatesForGear()
    //        let circleRadius = CGFloat(50)
    //        let decimalInput = 0.5
    //        let start = CGFloat(2 * CGFloat.pi)
    //        let end = start + CGFloat(Double.pi * decimalInput)
    //        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: true)
    //        circlePath.stroke()
    //    }
    
    
    func drawCircle(center: CGPoint, radius: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
        
    }
    func transparentSubview(rect: CGRect) {
        //let path: CGPath
        //
        let background = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        // Set a semi-transparent, black background.
        background.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        background.alignmentRect(forFrame: rect)
        
        // Create the initial layer from the view bounds.
        let maskLayer = CAShapeLayer()
        maskLayer.frame = background.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        
        // Create the frame for the circle.
        
        
        
        
//        let radius: CGFloat = 50.0
//        let rect = CGRect(x: background.frame.midX - radius, y: background.frame.midY - radius, width: 2 * radius, height: 2 * radius)
        
        
        
        
        // Create the path.
        let path = UIBezierPath(rect: background.bounds)
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // Append the circle to the path so that it is subtracted.
        path.append(UIBezierPath(ovalIn: rect))
        maskLayer.path = path.cgPath
        
        // Set the mask of the view.
        background.layer.mask = maskLayer
        
        // Add the view so it is visible.
        self.addSubview(background)
    }
}





















