//
//  PlanetWithPlaneView.swift
//  testCoreGraphics
//
//  Created by Kristina Del Rio Albrechet on 8/20/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

@IBDesignable
class PlanetView: UIView {
    
    var circleCenter: CGPoint!
    var circleRadius: CGFloat = 80
    var lineWidth: CGFloat = 7.0
    var fillColor = UIColor(displayP3Red: 0.435, green: 0.707, blue: 0.902, alpha: 1)
    let yAdditionForCurveParalel: CGFloat = 20
    
    
    override func draw(_ rect: CGRect) {
        circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)

        let planet = circlePath(center: circleCenter, radius: circleRadius)
        let straightMeridianAndParalel = straightMeridianAndParalelPath()
        let curveParalelTop = paralelPath(angleOne: CGFloat(7 * Double.pi / 4), angleTwo: CGFloat(5 * Double.pi / 4), isTop: true)
        let curveParalelBottom = paralelPath(angleOne: CGFloat(Double.pi / 4), angleTwo:  CGFloat(3 * Double.pi / 4), isTop:  false)
        let curveMeridians = curveMeridiansPath()
        
        // Setting lineWidth
        planet.lineWidth = lineWidth
        curveMeridians.lineWidth = lineWidth
        curveParalelTop.lineWidth = lineWidth
        curveParalelBottom.lineWidth = lineWidth
        straightMeridianAndParalel.lineWidth = lineWidth
        
        // Setting color for fill and stroke
        fillColor.setStroke()
        fillColor.setFill()
        
        planet.stroke()
        curveParalelTop.stroke()
        curveParalelBottom.stroke()
        curveMeridians.stroke()
        straightMeridianAndParalel.stroke()
    }
    
    /// Draws ovals inside rect in the center of the circle
    func curveMeridiansPath() -> UIBezierPath {
        let rect = CGRect(x: circleCenter.x - circleRadius / 2,
                          y: circleCenter.y - circleRadius,
                          width: circleRadius,
                          height: 2 * circleRadius)
        
        return  UIBezierPath(ovalIn: rect)
    }
    
    /// Draws planet circle
    private func circlePath(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat(Double.pi * 2),
                                clockwise: true)
        return path
    }
    
    /// Draws curve paralels on the top and down part of planet
    private func paralelPath(angleOne: CGFloat, angleTwo: CGFloat, isTop: Bool) -> UIBezierPath {
        let path = UIBezierPath()
        
        let startPoint = DegreesConverter.pointOnCircle(with: circleRadius, from: circleCenter, angle: angleOne)
        let endPoint =  DegreesConverter.pointOnCircle(with: circleRadius, from: circleCenter, angle: angleTwo)
        let ControlPointY = isTop ? circleCenter.y - yAdditionForCurveParalel : circleCenter.y + yAdditionForCurveParalel
        
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: CGPoint(x: circleCenter.x, y: ControlPointY))
        
        return path
    }
    
    /// Draws two diaments inside planet
    private func straightMeridianAndParalelPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: circleCenter.x, y: circleCenter.y + circleRadius))
        path.addLine(to: CGPoint(x: circleCenter.x, y: circleCenter.y - circleRadius))
        
        path.move(to: CGPoint(x: circleCenter.x + circleRadius, y: circleCenter.y))
        path.addLine(to: CGPoint(x: circleCenter.x - circleRadius, y: circleCenter.y))
        
        return path
    }
}

