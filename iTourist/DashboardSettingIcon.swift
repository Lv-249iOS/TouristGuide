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
        let radius: CGFloat = frame.width/3
        let x = getCenterCoordinatesOfButton().x
        let y = getCenterCoordinatesOfButton().y
        let lineWidth: CGFloat = 15.0
        let context = UIGraphicsGetCurrentContext()
        drawGear(x: x, y: y, radius: radius, context: context, lineWidth: lineWidth)

        context?.closePath()
        context?.fillPath()
    }
    
    func drawGear(x: CGFloat, y: CGFloat, radius: CGFloat, context: CGContext?, lineWidth: CGFloat) {
        if let checkedContext = context {
        teethDrawing(x: x, y: y, radius: radius, context: checkedContext)
        drawCircle(center: getCenterCoordinatesOfButton(), radius: radius, lineWidth: lineWidth)
        sectorDrawing(x: x, y: y, radius: radius)
        }
    }
    
    //Drawing circle, base
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
    //One tooth
    func drawSquare(x: CGFloat, y: CGFloat, width: CGFloat, context: CGContext?) -> CGPath?{
        let rect = CGRect(x: x + width, y: y-width/2, width: width , height: width)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat.init(3)).cgPath
        context?.addPath(clipPath)
        context?.setFillColor(UIColor.black.cgColor)
        return clipPath
    }
    //Calculate square side
    func getSideSquareSize(radius: CGFloat, angle: CGFloat) -> CGFloat {
        return radius*sqrt(2*(1 - cos(angle*CGFloat.pi/180)))
    }
    
    func teethDrawing(x: CGFloat, y: CGFloat, radius: CGFloat, context: CGContext) {
        var transform = CGAffineTransform(translationX: 0, y: 0)
        let pathSquare = drawSquare(x: x + radius*0.6 , y: y, width: getSideSquareSize(radius: radius, angle: 20.0), context: context)
        
        for var angle in stride(from: 0, to: 360, by: 45) {
            angle+=45
            transform = transform.translatedBy(x:x, y: y)
            transform = transform.rotated(by: CGFloat.init(CGFloat.pi*CGFloat.init(angle)/180))
            transform = transform.translatedBy(x: -x, y: -y)
            context.addPath((pathSquare?.copy(using: &transform))!)
        }
    }
    func sectorDrawing(x: CGFloat, y: CGFloat, radius: CGFloat) {
        let sectorPath1 = UIBezierPath()
        //Sector 1
        sectorPath1.move(to: CGPoint.init(x: x + 5, y: y + 5))
        sectorPath1.addArc(withCenter: CGPoint.init(x: x + 5, y: y + 5), radius: radius , startAngle: CGFloat(CGFloat.pi/180), endAngle: CGFloat(120*CGFloat.pi/180), clockwise: true)
        sectorPath1.addLine(to: CGPoint.init(x: x + 5 , y: y + 5))
        sectorPath1.close()
        //Sector 2
        let sectorPath2 = UIBezierPath()
        sectorPath2.move(to: CGPoint.init(x: x - 5 , y: y ))
        sectorPath2.addArc(withCenter: CGPoint.init(x: x - 5, y: y ), radius: radius , startAngle: CGFloat(120*CGFloat.pi/180), endAngle: CGFloat(240*CGFloat.pi/180), clockwise: true)
        sectorPath2.addLine(to: CGPoint.init(x: x - 5, y: y ))
        sectorPath2.close()
        //Sector 3
        let sectorPath3 = UIBezierPath()
        sectorPath3.move(to: CGPoint.init(x: x+5 , y: y - 5 ))
        sectorPath3.addArc(withCenter: CGPoint.init(x: x + 5 , y: y - 5 ), radius: radius , startAngle: CGFloat(240*CGFloat.pi/180), endAngle: CGFloat(360*CGFloat.pi/180), clockwise: true)
        sectorPath3.addLine(to: CGPoint.init(x: x+5 , y: y - 5 ))
        sectorPath3.close()
        
        let shapeLayer1 = CAShapeLayer()
        let shapeLayer2 = CAShapeLayer()
        let shapeLayer3 = CAShapeLayer()
        
        shapeLayer1.path = sectorPath1.cgPath
        shapeLayer2.path = sectorPath2.cgPath
        shapeLayer3.path = sectorPath3.cgPath
        //change the fill color
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.strokeColor = UIColor.black.cgColor
        shapeLayer1.lineWidth = 5.0
        
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.strokeColor = UIColor.black.cgColor
        shapeLayer2.lineWidth = 5.0
        
        shapeLayer3.fillColor = UIColor.clear.cgColor
        shapeLayer3.strokeColor = UIColor.black.cgColor
        shapeLayer3.lineWidth = 5.0
        
        self.layer.addSublayer(shapeLayer1)
        self.layer.addSublayer(shapeLayer2)
        self.layer.addSublayer(shapeLayer3)
    }
}
