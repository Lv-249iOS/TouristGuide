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
    var circleRadius: CGFloat = 80
    var lineWidth: CGFloat = 5
    
    var planeStrokeColor = UIColor.white // UIColor(colorLiteralRed: 0.051, green: 0.083, blue: 0.107, alpha: 1)
    var fillColor = UIColor(displayP3Red: 0.435, green: 0.707, blue: 0.902, alpha: 1)
    var planeScale: CGFloat = 0.7
    
    let partCircleRadiusConst: CGFloat = 40
    let yAdditionForCurveParalel: CGFloat = 20
    
    // Constants for distance of some element between them
    let stepDownForTail = (x: CGFloat(30), y: CGFloat(10))
    let stepUpForTail = (x: CGFloat(0), y: CGFloat(20))
    let stepToBody = (x: CGFloat(20), y: CGFloat(10))
    let stepToBodyTop = (x: CGFloat(3), y: CGFloat(40))
    let stepWidthWing = (x: CGFloat(50), y: CGFloat(0))
    let stepCurveWing = (x: CGFloat(0), y: CGFloat(17))
    let stepBowPart = (x: CGFloat(47), y: CGFloat(15)) // must be less than stepWidthWing.x (- 2)
    let stepHeightNose: CGFloat = 70
    static var angle: Degrees = 115
    
    override func draw(_ rect: CGRect) {
        circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let planeFootprint = footprintPath(centerPosition: circleCenter, radius: circleRadius * 1.45)
        let plane = planePath(startPos: CGPoint(x: planeFootprint.currentPoint.x + 120, y: bounds.midY - 50))
        
        let gradient = CAGradientLayer()
        gradient.position = CGPoint(x: planeFootprint.bounds.midX, y: planeFootprint.bounds.midY)
        gradient.bounds = planeFootprint.bounds
        gradient.colors = [UIColor.cyan.cgColor, UIColor.magenta.cgColor]
        
        let shapeMask = CAShapeLayer()
        shapeMask.path = planeFootprint.cgPath
        gradient.mask = shapeMask
        
        layer.addSublayer(gradient)
        
        let planeLayer = CAShapeLayer()
        planeLayer.path = plane.cgPath
        planeLayer.lineWidth = lineWidth
        planeLayer.fillColor = fillColor.cgColor
        planeLayer.strokeColor = planeStrokeColor.cgColor
        
        layer.addSublayer(planeLayer)
        plane.fill()
        
    }
    
    /// Draws footpints if the plane ...
    private func footprintPath(centerPosition: CGPoint, radius: CGFloat) -> UIBezierPath {
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
        
        // Plane tail (left part)
        let p1 = CGPoint(x: startPos.x - stepDownForTail.x * planeScale, y: startPos.y + stepDownForTail.y * planeScale)
        let p2 = CGPoint(x: p1.x + stepUpForTail.x, y: p1.y - stepUpForTail.y * planeScale)
        
        // Plane tail (right part)
        let p12 = CGPoint(x: startPos.x + stepDownForTail.x * planeScale, y: startPos.y + stepDownForTail.y * planeScale)
        let p11 = CGPoint(x: p12.x + stepUpForTail.x * planeScale, y: p12.y - stepUpForTail.y * planeScale)
        
        // Plane body (left part)
        let p3 = CGPoint(x: p2.x + stepToBody.x * planeScale, y: p2.y - stepToBody.y * planeScale)
        let p4 = CGPoint(x: p3.x - stepToBodyTop.x * planeScale, y: p3.y - stepToBodyTop.y * planeScale)
        
        // Plane body (right part)
        let p10 = CGPoint(x: p11.x - stepToBody.x * planeScale, y: p11.y - stepToBody.y * planeScale)
        let p9 = CGPoint(x: p10.x + stepToBodyTop.x * planeScale, y: p10.y - stepToBodyTop.y * planeScale)
        
        // Plane wing (left)
        let p5 = CGPoint(x: p4.x - stepWidthWing.x * planeScale, y: p4.y + stepWidthWing.y * planeScale)
        let p5_1 = CGPoint(x: p5.x + stepCurveWing.x, y: p5.y - stepCurveWing.y * planeScale)
        let p6 = CGPoint(x: p5_1.x + stepBowPart.x * planeScale, y: p5_1.y - stepBowPart.y * planeScale)
        
        // Plane wing (right)
        let p8 = CGPoint(x: p9.x + stepWidthWing.x * planeScale, y: p9.y + stepWidthWing.y * planeScale)
        let p7_1 = CGPoint(x: p8.x + stepCurveWing.x * planeScale, y: p8.y - stepCurveWing.y * planeScale)
        let p7 = CGPoint(x: p7_1.x - stepBowPart.x * planeScale, y: p7_1.y - stepBowPart.y * planeScale)
        
        // Control points
        let controlPointForBow1 = CGPoint(x: p6.x, y: p6.y - stepHeightNose * planeScale)
        let controlPointForBow2 = CGPoint(x: p7.x, y: p7.y - stepHeightNose * planeScale)
        let controlPointForLeftWing = CGPoint(x: p5.x - stepCurveWing.y * planeScale, y: p5_1.y + stepCurveWing.y * planeScale)
        let controlPointForRightWing = CGPoint(x: p7_1.x + stepCurveWing.y * planeScale, y: p7_1.y + stepCurveWing.y * planeScale)
        
        // MARK: Points must be in order
        return [p1, p2, p3, p4, p5, p5_1, controlPointForLeftWing, p6, p7, controlPointForBow1, controlPointForBow2, p7_1, p8, controlPointForRightWing, p9, p10, p11, p12]
    }
}
