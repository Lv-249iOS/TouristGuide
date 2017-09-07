//
//  PlaneView.swift
//  testCoreGraphics
//
//  Created by Kristina Del Rio Albrechet on 8/21/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

@IBDesignable
class PlaneView: UIView {
    
    var circleCenter: CGPoint!
    
    // general parametrs
    @IBInspectable var circleRadius: CGFloat = 80
    @IBInspectable var lineWidth: CGFloat = 5
    @IBInspectable var planeStrokeColor: UIColor = UIColor.white
    @IBInspectable var fillColor: UIColor = DefaultColor.lightBlue
    @IBInspectable var planeScale: CGFloat = 0.7
    @IBInspectable var planeXposition: CGFloat = 120
    @IBInspectable var planeYposition: CGFloat = -50
    
    // Plane parametrs for x position
    @IBInspectable var xDownForTail: CGFloat = 30
    @IBInspectable var xUpForTail: CGFloat = 0
    @IBInspectable var xToBody: CGFloat = 20
    @IBInspectable var xToBodyTop: CGFloat = 3
    @IBInspectable var xWidthWing: CGFloat = 50
    @IBInspectable var xCurveWing: CGFloat = 0
    @IBInspectable var xBowPart: CGFloat = 47 // must be less then xWidthWing
    
    // Plane parametrs for y position
    @IBInspectable var yDownForTail: CGFloat = 10
    @IBInspectable var yUpForTail: CGFloat = 20
    @IBInspectable var yToBody: CGFloat = 10
    @IBInspectable var yToBodyTop: CGFloat = 40
    @IBInspectable var yWidthWing: CGFloat = 0
    @IBInspectable var yCurveWing: CGFloat = 17
    @IBInspectable var yBowPart: CGFloat = 15
    
    @IBInspectable var stepHeightNose: CGFloat = 70
    /// Drawing inside view
    override func draw(_ rect: CGRect) {
        layer.sublayers = []
    
        circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let planeFootprint = footprintPath(centerPosition: circleCenter, radius: circleRadius * 1.45)
        let plane = planePath(startPos: CGPoint(x: planeFootprint.currentPoint.x + planeXposition,
                                                y: bounds.midY + planeYposition))
        
        
        layer.addSublayer(gradientLayer(with: planeFootprint))
        
        let planeLayer = CAShapeLayer()
        planeLayer.path = plane.cgPath
        planeLayer.lineWidth = lineWidth
        planeLayer.fillColor = fillColor.cgColor
        planeLayer.strokeColor = planeStrokeColor.cgColor
        
        layer.addSublayer(planeLayer)
    }
    
    /// Creates gradient layer using mask laid on layer
    func gradientLayer(with path: UIBezierPath) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.position = CGPoint(x: path.bounds.midX, y: path.bounds.midY)
        gradient.bounds = path.bounds
        gradient.colors = [UIColor.cyan.cgColor, UIColor.magenta.cgColor]
        
        let shapeMask = CAShapeLayer()
        shapeMask.path = path.cgPath
        gradient.mask = shapeMask
        
        return gradient
    }
    
    /// Draws footpints if the plane ...
    func footprintPath(centerPosition: CGPoint, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: centerPosition,
                                radius: radius,
                                startAngle: DegreesConverter.radians(from: 135),
                                endAngle: DegreesConverter.radians(from: 271),
                                clockwise: true)
        
        let endPos = DegreesConverter.pointOnCircle(with: radius, from: centerPosition, angle: DegreesConverter.radians(from: 135))
        let ctrlPoint1 = DegreesConverter.pointOnCircle(with: radius + radius / 1.2, from: centerPosition, angle: DegreesConverter.radians(from: 210))
        let ctrlPoint2 = DegreesConverter.pointOnCircle(with: radius + radius / 4, from: centerPosition, angle: DegreesConverter.radians(from: 150))
        
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - lineWidth))
        path.addCurve(to: endPos, controlPoint1: ctrlPoint1, controlPoint2: ctrlPoint2)
        
        return path
    }
    
    /// Draws plane
    func planePath(startPos: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        let points = generatePoints(with: startPos)
        
        path.move(to: startPos)
        
        path.addLine(to: points[0])
        path.addLine(to: points[1])
        path.addLine(to: points[2])
        path.addLine(to: points[3])
        path.addLine(to: points[4])
        path.addQuadCurve(to: points[5], controlPoint: points[6])
        path.addLine(to: points[7])
        path.addCurve(to: points[8], controlPoint1: points[9], controlPoint2: points[10])
        path.addLine(to: points[11])
        path.addQuadCurve(to: points[12], controlPoint: points[13])
        path.addLine(to: points[14])
        path.addLine(to: points[15])
        path.addLine(to: points[16])
        path.addLine(to: points[17])
        
        path.close()
        
        // Rotate plane to 115 degrees
        let center = CGPoint(x: path.bounds.midX, y: path.bounds.midY)
        path.apply(CGAffineTransform(translationX: center.x, y: center.y).inverted())
        path.apply(CGAffineTransform(rotationAngle: DegreesConverter.radians(from: 115)))
        path.apply(CGAffineTransform(translationX: center.x, y: center.y))
        
        return path
    }
    
    /// Creates all the points of plane
    private func generatePoints(with startPos: CGPoint) -> [CGPoint] {
        
        // Plane tail
        let p1 = CGPoint(x: startPos.x - xDownForTail * planeScale, y: startPos.y + yDownForTail * planeScale)
        let p2 = CGPoint(x: p1.x + xUpForTail, y: p1.y - yUpForTail * planeScale)
        let p12 = CGPoint(x: startPos.x + xDownForTail * planeScale, y: startPos.y + yDownForTail * planeScale)
        let p11 = CGPoint(x: p12.x + xUpForTail * planeScale, y: p12.y - yUpForTail * planeScale)
        
        // Plane body
        let p3 = CGPoint(x: p2.x + xToBody * planeScale, y: p2.y - yToBody * planeScale)
        let p4 = CGPoint(x: p3.x - xToBodyTop * planeScale, y: p3.y - yToBodyTop * planeScale)
        let p10 = CGPoint(x: p11.x - xToBody * planeScale, y: p11.y - yToBody * planeScale)
        let p9 = CGPoint(x: p10.x + xToBodyTop * planeScale, y: p10.y - yToBodyTop * planeScale)
        
        // Plane wing
        let p5 = CGPoint(x: p4.x - xWidthWing * planeScale, y: p4.y + yWidthWing * planeScale)
        let p5_1 = CGPoint(x: p5.x + xCurveWing, y: p5.y - yCurveWing * planeScale)
        let p6 = CGPoint(x: p5_1.x + xBowPart * planeScale, y: p5_1.y - yBowPart * planeScale)
        let p8 = CGPoint(x: p9.x + xWidthWing * planeScale, y: p9.y + yWidthWing * planeScale)
        let p7_1 = CGPoint(x: p8.x + xCurveWing * planeScale, y: p8.y - yCurveWing * planeScale)
        let p7 = CGPoint(x: p7_1.x - xBowPart * planeScale, y: p7_1.y - yBowPart * planeScale)
        
        // Control points
        let ctrlPointForBow1 = CGPoint(x: p6.x, y: p6.y - stepHeightNose * planeScale)
        let ctrlPointForBow2 = CGPoint(x: p7.x, y: p7.y - stepHeightNose * planeScale)
        let ctrlPointForLeftWing = CGPoint(x: p5.x - yCurveWing * planeScale, y: p5_1.y - yCurveWing * planeScale)
        let ctrlPointForRightWing = CGPoint(x: p7_1.x + yCurveWing * planeScale, y: p7_1.y + yCurveWing * planeScale)
        
        // MARK: Points must be in order
        return [p1, p2, p3, p4, p5, p5_1, ctrlPointForLeftWing, p6, p7, ctrlPointForBow1, ctrlPointForBow2, p7_1, p8, ctrlPointForRightWing, p9, p10, p11, p12]
    }
}
