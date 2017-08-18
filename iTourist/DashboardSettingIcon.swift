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
    
    func getCoordinatesForGear() -> CGPoint {
        return CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
    }
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
    override func draw(_ rect: CGRect) {
        //let context = UIGraphicsGetCurrentContext()
//        drawCircle(center: getCoordinatesForGear(), radius: 70)
//        drawCircle(center: getCoordinatesForGear(), radius: 50)
//        drawCircle(center: getCoordinatesForGear(), radius: 30)
        
        let circleCenter = getCoordinatesForGear()
        let circleRadius = CGFloat(50)
        let decimalInput = 0.5
        let start = CGFloat(2 * CGFloat.pi)
        let end = start + CGFloat(Double.pi * decimalInput)
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: true)
        circlePath.stroke()
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
class DashboardSettingIcon_1: RoundButton {
    
    private let tooth: Double = 36 //N
    private let pitchSpurGear: Double = 24 //P
    
    override func draw(_ rect: CGRect) {
        //The context is the object used for drawing
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3.0)
        context?.setStrokeColor(UIColor.black.cgColor)
        
        //Create a path
        context?.move(to: CGPoint.init(x: 50, y: 60))
        context?.addLine(to: CGPoint.init(x: 250, y: 320))
        
        //Actually draw the path
        context?.strokePath()
    }
    
    //1. Calculate and draw the PitchCircle
    func diameterOfPitchCircle(tooth: Double, pitchSpurGear: Double) -> Double { //D
        return tooth/pitchSpurGear
    }
    
    //2. Calculate and draw the RootCircle
    func rootCircleDiameter(tooth: Double, pitchSpurGear: Double) -> Double { //RD
        return (tooth - 2)/pitchSpurGear
    }
    //3. Calculate and draw the OutsideCircle
    func outsideCircleDiameter(tooth: Double, pitchSpurGear: Double) -> Double {//OD
        return (tooth + 2)/pitchSpurGear
    }
    
    //4. Draw a vertical center line (AB) from the center of the circles to a point outside the circles
    func drawVerticalLine() {
        
    }
    //5. Calculate and layout the Circular Thickness angle to the left (CC W) of the vertical center line
    //Calculate the angular measurement for the circular thickness
    
    func circleThicknessAngle(tooth: Double) -> Double {
        //In the equation above, it is necessary to multiply by 0.5 (or divide by 2) since there are always
        //an equal number of teeth and spaces in each gear!
        return (Double.pi / tooth) * 0.5
    }
    //6. Draw the Pressure Line. The pressure line is drawn through the pitch point at an angle of 20 degrees from a line tangent to the top of the pitch circle.
    func drawPresureline() {
        
    }
    //7. Create a line that bisects the circular thickness angle. This line should intersect or extend beyond the outside circle
    func drawLineBisectsCircularThicknessAngle() {
        
    }
    //8. Beginning at the center of the circles, draw the Base Circle tangent to the 20 degree pressure line
    /*  Note:
     that in this 36 tooth, 24 pitch gear, the base circle will have
     nearly the same diameter as the root circle. This will not be the case with spur gears having
     different numbers of teeth, or different pitch. Therefore it is necessary to follow these
     instructions closely in order to establish accurate gear tooth geometry.
     */
    func drawBaseCircle() {
        
    }
    //9.  Locate the Tooth Form Circle by drawing circle (A) whose radius is 1/8 of the Pitch Diameter and whose center is at the PitchPoint
    func drawToothFormCircle() {
        
    }
    //10.  Draw another circle (B) of the same radius whose center is at the intersection of circle A and the Base Circle. This circle will form the top right curve of the gear tooth
    //I can write universal method for drawing this circle
    
    //11. Erase Circle A and trim away all of circle B, except the tooth form which is arc PT beginning at the pitch point and intersecting the outside circle. Erase the Base circle.
    
    //12. The tooth form is generated from the PitchPoint. Continue developing the gear tooth form by tracing over the vertical centerline and trimming away the outside circle. After creating the tooth form, erase all lines EXCEPT the circular thickness bisector, the tooth from lines and the base circle
    //13. Mirror the tooth form lines about the circular thickness bisector
    //14. Erase the circular thickness bisector and array the completed tooth form about the base circle
    //15. Trim the base circle line under each tooth to create a single closed form
    //16. Extrude the gear a distance of 0.25”. This dimension is given in the specifications on the first page of this text. Note: If the gear does not extrude, zoom into the original tooth form and check for irregularities such as additional lines, broken lines or lines that have been drawn over other lines.
}





















