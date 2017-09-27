//
//  MapButton.swift
//  iTourist
//
//  Created by AndreOsip on 8/21/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

@IBDesignable class MapButton : RoundButton {

    override func draw(_ rect: CGRect) {
        let π: CGFloat = CGFloat.pi
        
        let radius: CGFloat = max(bounds.width, bounds.height)/20
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2*π
        let circleWidth: CGFloat = 10
        
        func drawAnnotation(with point: CGPoint, color: UIColor) {
            
            let path = UIBezierPath(arcCenter: point, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = circleWidth
            
            color.setStroke()
            path.stroke()
            
            let tringlePath = UIBezierPath()
            tringlePath.lineWidth = 1
            
            let TringlePoint1 = DegreesConverter.pointOnCircle(with: radius+circleWidth/2, from: point, angle: CGFloat(π/6))
            
            let TringleButtom = CGPoint(x: point.x, y: point.y + radius*3)
            
            let TringlePoint2 = DegreesConverter.pointOnCircle(with: radius+circleWidth/2, from: point, angle: CGFloat(5/6*π))
                //CGPoint(x: point.x + radius+circleWidth/2, y: point.y + radius)
            
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
        
        let routePoint1 = CGPoint(x: leftAnnotationPoint.x, y: leftAnnotationPoint.y + radius*3)
        let routePoint2 = CGPoint(x: rightAnnotationPoint.x, y: rightAnnotationPoint.y + radius*3)

        
        let path = UIBezierPath()
        //path.move(to: routePoint1)
        var lineEndingPoint = CGPoint()
        
        for i in stride(from: routePoint1.x, through: routePoint2.x+20, by: 20) {
            let point = CGPoint(x: i, y: routePoint1.y)
            let point2 = CGPoint(x: i+10, y: routePoint1.y)
            path.move(to: point)
        path.addLine(to: point2)
            lineEndingPoint = CGPoint(x: point2.x, y: point2.y-20)
        }
        let path2Arc = UIBezierPath(arcCenter: lineEndingPoint, radius: 20, startAngle: CGFloat(3/2*π), endAngle: CGFloat(π/2), clockwise: true)
        path2Arc.lineWidth = 4
        
        UIColor.orange.setStroke()
        path2Arc.stroke()
        
        
        
        path.lineWidth = 4
        UIColor.orange.setStroke()
        path.stroke()
        
    }


}
