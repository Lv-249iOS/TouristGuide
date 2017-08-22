//
//  WeatherbuttonWithIcon.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/21/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class WeatherbuttonWithIcon: RoundButton {
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        var radius: Double = 0.0
        radius = min(Double(rect.height), Double(rect.width)) / 3
        let center = CGPoint(x: rect.width/2, y: rect.height / 2)
        if let checkedContext = context {
            circledrawing(center: center, radius: CGFloat(radius), lineWidth: 6, context: checkedContext)
            allTrianglesDrawing(x: center.x, y: center.y, radius: CGFloat(radius), lineWidth: 4, context: checkedContext )
            context?.strokePath()
        }
    }
    
    func circledrawing(center: CGPoint, radius: CGFloat, lineWidth: CGFloat, context: CGContext?) {
        let radiusPro = radius * 0.8
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x + CGFloat(radiusPro), y: center.y ))
        for i in stride(from: 0, to: 361.0, by: 10) {
            
            let radians = i * Double.pi / 180
            let x = Double(center.x) + Double(radiusPro) * cos(radians)
            let y = Double(center.y) + Double(radiusPro) * sin(radians)
            path.addLine(to: CGPoint(x: x, y: y))
            
        }
        path.lineWidth = lineWidth
        UIColor.orange.setStroke()
        path.stroke()
    }
    
    func drawtriangle(x: CGFloat, y: CGFloat,radius: CGFloat,lineWidth: CGFloat, context: CGContext?)-> CGPath?
    {
        let pathtriangle = UIBezierPath()
        let center = CGPoint(x: x, y: y + radius)
        pathtriangle.move(to: center)
        let pointOne = CGPoint(x: center.x - radius / 4, y: center.y )
        pathtriangle.addLine(to: pointOne)
        let pointTwo = CGPoint(x: center.x + radius / 4, y: center.y )
        pathtriangle.addLine(to: pointTwo)
        let pointTree = CGPoint(x:center.x , y: center.y + radius / 3)
        pathtriangle.addLine(to: pointTree)
        pathtriangle.addLine(to: pointOne)
        pathtriangle.lineWidth = lineWidth
        pathtriangle.close()
        pathtriangle.stroke()
        context?.addPath(pathtriangle.cgPath)
        return context?.path
    }
    
    func allTrianglesDrawing(x: CGFloat, y: CGFloat, radius: CGFloat,lineWidth: CGFloat, context: CGContext?) {
        var transform = CGAffineTransform(translationX: 0, y: 0)
        for var angle in stride(from: 0, to: 360, by: 45) {
            angle = angle + 45
            transform = transform.translatedBy(x:x, y: y)
            transform = transform.rotated(by: CGFloat.init(CGFloat.pi*CGFloat.init(angle)/180))
            transform = transform.translatedBy(x: -x, y: -y)
            let pathtriangle = drawtriangle(x: x , y: y, radius: radius, lineWidth: lineWidth, context: context)
            context?.addPath((pathtriangle?.copy(using: &transform))!)
        }
    }
    
    
    
}
