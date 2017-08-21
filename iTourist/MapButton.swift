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
        let π: CGFloat = CGFloat(M_PI)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2*π
        
        func drawAnnotation(with point: CGPoint, color: UIColor) {
            
            let path = UIBezierPath(arcCenter: point, radius: radius/20, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = 10
            
            color.setStroke()
            path.stroke()
            
            let tringlePath = UIBezierPath()
            tringlePath.lineWidth = 1
            
            let TringlePoint1 = CGPoint(x: point.x - radius/15, y: point.y + radius/35)
            
            let TringleButtom = CGPoint(x: point.x, y: point.y + radius/7)
            
            let TringlePoint2 = CGPoint(x: point.x + radius/15, y: point.y + radius/35)
            
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
        
        let routePoint1 = CGPoint(x: leftAnnotationPoint.x, y: leftAnnotationPoint.y + radius/7)
        let routePoint2 = CGPoint(x: rightAnnotationPoint.x, y: rightAnnotationPoint.y + radius/7)
        let center = CGPoint(x: bounds.width/2, y: bounds.height/1.5)
        let center2 = CGPoint(x: bounds.width, y: bounds.height)
        
        let path = UIBezierPath()
        path.move(to: routePoint1)
        path.addQuadCurve(to: center, controlPoint: center2)
        path.addLine(to: routePoint2)
        path.lineWidth = 2
        UIColor.blue.setStroke()
        path.stroke()
        
    }


}
