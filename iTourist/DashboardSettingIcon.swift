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
    
    override func draw(_ rect: CGRect) {
        drawGear()
    }
    
    func drawGear() {
        let radius: CGFloat = min(frame.width, frame.height)/3
        let x = getCenterCoordinatesOfButton().x
        let y = getCenterCoordinatesOfButton().y
        let lineWidth: CGFloat = 17.0
        let sectorLineWidth: CGFloat = 3.0
        let context = UIGraphicsGetCurrentContext()
        if let checkedContext = context {
            teethDrawing(x: x, y: y, radius: radius, context: checkedContext)
            sectorDrawing(x: x, y: y, radius: radius - (2*sectorLineWidth), context: checkedContext, lineWidth: sectorLineWidth)
            drawCircle(center: getCenterCoordinatesOfButton(), radius: radius, lineWidth: lineWidth, context: checkedContext)
            context?.strokePath()
        }
    }
    
    //Drawing circle, base
    func drawCircle(center: CGPoint, radius: CGFloat, lineWidth: CGFloat, context: CGContext?) {
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
        context?.addPath(circlePath.cgPath)
        context?.setLineWidth(lineWidth)
        context?.strokePath()
        //self.layer.addSublayer(shapeLayer)
    }
    
    //One tooth
    func drawSquare(x: CGFloat, y: CGFloat, width: CGFloat, context: CGContext?) -> CGPath?{
        let rect = CGRect(x: x + width, y: y-width/2, width: width , height: width)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat.init(3))
        let clipPath: CGPath = bezierPath.cgPath
        context?.addPath(clipPath)
        context?.setFillColor(UIColor.black.cgColor)
        return context?.path
    }
    
    //Drawing a lot of squares
    func teethDrawing(x: CGFloat, y: CGFloat, radius: CGFloat, context: CGContext?) {
        var transform = CGAffineTransform(translationX: 0, y: 0)
        let pathSquare = drawSquare(x: x + radius*0.6 , y: y, width: getSideSquareSize(radius: radius, angle: 20.0), context: context)
        for var angle in stride(from: 0, to: 360, by: 45) {
            angle+=45
            transform = transform.translatedBy(x:x, y: y)
            transform = transform.rotated(by: CGFloat.init(CGFloat.pi*CGFloat.init(angle)/180))
            transform = transform.translatedBy(x: -x, y: -y)
            context?.addPath((pathSquare?.copy(using: &transform))!)
        }
        context?.fillPath()
    }
    
    //Drawing sectors, sectors it like a base for gear, inside gear
    func sectorDrawing(x: CGFloat, y: CGFloat, radius: CGFloat, context: CGContext?, lineWidth: CGFloat) {
        let sectorPath1 = UIBezierPath()
        let sectorPath2 = UIBezierPath()
        let sectorPath3 = UIBezierPath()
        //Sector 1
        sectorPath1.move(to: CGPoint.init(x: x + 5, y: y + 5))
        
        sectorPath1.addArc(withCenter: CGPoint.init(x: x + 5, y: y + 5), radius: radius , startAngle: CGFloat(CGFloat.pi/180), endAngle: CGFloat(120*CGFloat.pi/180), clockwise: true)
        sectorPath1.addLine(to: CGPoint.init(x: x + 5 , y: y + 5))
        sectorPath1.stroke()
        sectorPath1.close()
        
        //Sector 2
        sectorPath2.move(to: CGPoint.init(x: x - 5 , y: y ))
        sectorPath2.addArc(withCenter: CGPoint.init(x: x - 5, y: y ), radius: radius , startAngle: CGFloat(120*CGFloat.pi/180), endAngle: CGFloat(240*CGFloat.pi/180), clockwise: true)
        sectorPath2.addLine(to: CGPoint.init(x: x - 5, y: y ))
        sectorPath2.stroke()
        sectorPath2.close()
        
        //Sector 3
        sectorPath3.move(to: CGPoint.init(x: x+5 , y: y - 5 ))
        sectorPath3.addArc(withCenter: CGPoint.init(x: x + 5 , y: y - 5 ), radius: radius , startAngle: CGFloat(240*CGFloat.pi/180), endAngle: CGFloat(360*CGFloat.pi/180), clockwise: true)
        sectorPath3.addLine(to: CGPoint.init(x: x+5 , y: y - 5 ))
        sectorPath3.stroke()
        sectorPath3.close()
        
        let shapeLayer1 = CAShapeLayer()
        let shapeLayer2 = CAShapeLayer()
        let shapeLayer3 = CAShapeLayer()
        
        shapeLayer1.path = sectorPath1.cgPath
        shapeLayer2.path = sectorPath2.cgPath
        shapeLayer3.path = sectorPath3.cgPath
        
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.strokeColor = UIColor.black.cgColor
        shapeLayer1.lineWidth = 5.0
        
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.strokeColor = UIColor.black.cgColor
        shapeLayer2.lineWidth = 5.0
        
        shapeLayer3.fillColor = UIColor.clear.cgColor
        shapeLayer3.strokeColor = UIColor.black.cgColor
        shapeLayer3.lineWidth = 5.0
        
        context?.addPath(shapeLayer1.path!)
        context?.addPath(shapeLayer2.path!)
        context?.addPath(shapeLayer3.path!)
        context?.setLineWidth(lineWidth)
        context?.strokePath()

    }
    
    //Center of button
    func getCenterCoordinatesOfButton() -> CGPoint {
        return CGPoint.init(x: self.frame.width/2, y: self.frame.height/2)
    }
    
    //Calculate square side
    func getSideSquareSize(radius: CGFloat, angle: CGFloat) -> CGFloat {
        return radius*sqrt(2*(1 - cos(angle*CGFloat.pi/180)))
    }
}
