//
//  MapButton.swift
//  iTourist
//
//  Created by AndreOsip on 8/21/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

@IBDesignable class MapButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        let π: CGFloat = CGFloat.pi
        
        let radius: CGFloat = max(bounds.width, bounds.height)/20
        
        func drawAnnotation(with point: CGPoint, color: UIColor) {
            
            let path = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0, endAngle: 2*π, clockwise: true)
            path.lineWidth = 10
            
            color.setStroke()
            path.stroke()
            
            let tringlePath = UIBezierPath()
            
            let TringlePoint1 = DegreesConverter.pointOnCircle(with: radius+5, from: point, angle: CGFloat(π/6))
            
            let TringleButtom = CGPoint(x: point.x, y: point.y + radius*2)
            
            let TringlePoint2 = DegreesConverter.pointOnCircle(with: radius+5, from: point, angle: CGFloat(5/6*π))
            
            tringlePath.move(to: TringlePoint1)
            tringlePath.addLine(to: TringleButtom)
            tringlePath.addLine(to: TringlePoint2)
            tringlePath.close()
            
            color.setFill()
            tringlePath.fill()
        }
        
        
        let rightAnnotationPoint = CGPoint(x: bounds.width - bounds.width/3.5, y: bounds.height/3.5)
        let leftAnnotationPoint = CGPoint(x: bounds.width/3.5, y:bounds.height - bounds.height/3.5)
        
        drawAnnotation(with: rightAnnotationPoint, color: UIColor.red)
        drawAnnotation(with: leftAnnotationPoint, color: UIColor.black)
        
        ////////////////////////////////////////////////////////////////////////////
        
        let radiusForRoute = (leftAnnotationPoint.y - rightAnnotationPoint.y)/8
        let xDistance = rightAnnotationPoint.x - leftAnnotationPoint.x
        
        var routePoint1 = CGPoint(x: leftAnnotationPoint.x, y: leftAnnotationPoint.y + radius*2)
        var routePoint2 = CGPoint(x: rightAnnotationPoint.x, y: leftAnnotationPoint.y + radius*2)
        
        var lineEndingPoint = CGPoint()
        
        func drawHorizontalDashLine(start: CGPoint, end: CGPoint, step: CGFloat) {
            let path = UIBezierPath()
            for i in stride(from: start.x, through: end.x, by: step) {
                
                let point = CGPoint(x: i, y: start.y)
                let point2 = CGPoint(x: i+step/2, y: start.y)
                
                path.move(to: point)
                path.addLine(to: point2)
                lineEndingPoint = CGPoint(x: point2.x, y: point2.y-radiusForRoute)
                
                path.lineWidth = 4
                UIColor.orange.setStroke()
                path.stroke()
                
            }
        }
        
        func drawArc(startAngle: CGFloat, endAngle: CGFloat){
            
            let path2Arc = UIBezierPath(arcCenter: lineEndingPoint, radius: radiusForRoute, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            path2Arc.lineWidth = 4
            path2Arc.stroke()
        }
        
        //from left to right
        drawHorizontalDashLine(start: routePoint1, end: routePoint2, step: 20)
        drawArc(startAngle: CGFloat(7*π/4), endAngle: CGFloat(π/4))
        
        
        //from right to left
        routePoint1 = CGPoint(x: lineEndingPoint.x, y: lineEndingPoint.y-radiusForRoute)
        routePoint2 = CGPoint(x: routePoint1.x-xDistance/2, y: lineEndingPoint.y-radiusForRoute)
        
        drawHorizontalDashLine(start: routePoint1, end: routePoint2, step: -20)
        drawArc(startAngle: CGFloat(3*π/4), endAngle: CGFloat(5*π/4))
        
        //from left to right
        routePoint1 = CGPoint(x: lineEndingPoint.x, y: lineEndingPoint.y-radiusForRoute)
        routePoint2 = CGPoint(x: routePoint1.x+xDistance/2, y: lineEndingPoint.y-radiusForRoute)
        
        drawHorizontalDashLine(start: routePoint1, end: routePoint2, step: 20)
        drawArc(startAngle: CGFloat(7*π/4), endAngle: CGFloat(π/4))
        
        //from right to left
        routePoint1 = CGPoint(x: lineEndingPoint.x, y: lineEndingPoint.y-radiusForRoute)
        routePoint2 = CGPoint(x: lineEndingPoint.x-2, y: lineEndingPoint.y-radiusForRoute)
        
        drawHorizontalDashLine(start: routePoint1, end: routePoint2, step: -20)
        drawArc(startAngle: CGFloat(3*π/4), endAngle: CGFloat(5*π/4))
        
        //from left to right
        routePoint1 = CGPoint(x: lineEndingPoint.x, y: lineEndingPoint.y-radiusForRoute)
        routePoint2 = CGPoint(x: rightAnnotationPoint.x, y: lineEndingPoint.y-radiusForRoute)
        
        drawHorizontalDashLine(start: routePoint1, end: routePoint2, step: 20)
        
    }
    
}
