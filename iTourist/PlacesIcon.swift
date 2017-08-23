//
//  PlacesIcon.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/22/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

@IBDesignable class PlacesIcon: UIButton {
    
    
    
    override func draw(_ rect: CGRect) {
        drawMuseum(rect)
    }
    
    func drawMuseum(_ rect: CGRect) {
        let width = bounds.width
        let height = bounds.height
        let startPoint = CGPoint(x: bounds.width/2, y: bounds.height/4.675)
        let pathMuseum = UIBezierPath()
        let lineWidth: CGFloat = 1
        // Draw roof
        pathMuseum.lineWidth = lineWidth
        pathMuseum.move(to: startPoint)
        let pointOne = CGPoint(x: startPoint.x - width * 0.350, y: startPoint.y + height * 0.311)
        pathMuseum.addLine(to: pointOne)
        pathMuseum.addLine(to: CGPoint(x: startPoint.x + width * 0.350, y: pointOne.y))
        pathMuseum.close()
        UIColor.purple.setStroke()
        pathMuseum.stroke()
        
        
        // Draw columns
        let pathColumns = UIBezierPath()
        let pointThree = CGPoint(x: pointOne.x + width * 0.4666 , y: pointOne.y + height * 0.187)
        pathColumns.move(to: pointThree)
        pathColumns.addLine(to:CGPoint(x: pointThree.x + width * 0.4666 , y: pointThree.y + height * 0.481 ))
        UIColor.purple.setStroke()
        pathColumns.stroke()
  
        let pathSquareOne = UIBezierPath(rect: CGRect(x: pointOne.x, y: pointOne.y, width: 2 * width * 0.350, height: 10))
        
        
        pathSquareOne.stroke()
        
        
        
     
        
        
        
    }

//    @IBInspectable var scaleMuseum: CGFloat = 1
//    @IBInspectable var lineWidth: CGFloat = 5
//    
//    // X - positions of roof and spike:
//
//    @IBInspectable var xRoofPointOne: CGFloat = 30
//    @IBInspectable var xRoofPointTwo: CGFloat = 58
//    
//    // Y - positions of roof and spike:
//    @IBInspectable var yRoofPointOne: CGFloat = 20
//    
//    // Width of squares:
//    @IBInspectable var squareFirstWidth: CGFloat = 58
//    @IBInspectable var squareTwoWidth: CGFloat = 58
//    @IBInspectable var squareThreeWidth: CGFloat = 64
//    
//    // Height of squares:
//    @IBInspectable var squaresHeight: CGFloat = 5
//    
//    // X - positions of columns:
//    @IBInspectable var xStartUpPoint: CGFloat = 3
//    @IBInspectable var yStartUpPoint: CGFloat = 5
//    @IBInspectable var xStartDownPoint: CGFloat = 2
//    @IBInspectable var yStartDownPoint: CGFloat = 45
//    @IBInspectable var smallSpace: CGFloat = 4
//    @IBInspectable var largeSpace: CGFloat = 8
//    
//    override func draw(_ rect: CGRect) {
////        scaleMuseum = rect.size.height > rect.size.width ? 2 : 0.9
//        print(frame.width)
//        print(frame.height)
//
//       
//        if rect.size.height > rect.size.width {
//            scaleMuseum = 2
//            lineWidth = 5
//        } else {
//            scaleMuseum = 0.9
////            let temp = height
////            height = width
////            width = temp
//            lineWidth = 2
//        }
//        
//        
//            drawMuseum(rect)
//        
//
//    }
//    
//    func drawMuseum(_ rect: CGRect) {
//
//        // Draw roof
//        let pathRoof = UIBezierPath()
//        pathRoof.lineWidth = lineWidth
//
//        pathRoof.move(to: pointSpike)
//        let pointOne = CGPoint(x: pointSpike.x - xRoofPointOne * scaleMuseum, y: pointSpike.y + yRoofPointOne * scaleMuseum)
//        pathRoof.addLine(to: pointOne)
//        
//        let pointTwo = CGPoint(x: pointOne.x + xRoofPointTwo * scaleMuseum, y: pointOne.y)
//        pathRoof.addLine(to: pointTwo)
//        pathRoof.close()
//        pathRoof.stroke()
//        
//        // Draw square under the roof
//        let pathSquare = UIBezierPath(rect: CGRect(x: pointOne.x, y: pointOne.y, width: squareFirstWidth * scaleMuseum, height: squaresHeight * scaleMuseum))
//        pathSquare.lineWidth = lineWidth
//       
//        pathSquare.stroke()
//        
//        
//        // Draw colomns
//        let pathWalls = UIBezierPath()
//        pathWalls.lineWidth = lineWidth
//        
//        let pointThree = CGPoint(x: pointOne.x + xStartUpPoint * scaleMuseum, y: pointOne.y + yStartUpPoint * scaleMuseum)
//        pathWalls.move(to: pointThree)
//        
//        let pointFour = CGPoint(x: pointThree.x - xStartDownPoint * scaleMuseum, y: pointThree.y + yStartDownPoint * scaleMuseum)
//        pathWalls.addLine(to: pointFour)
//        
//        pathWalls.move(to: CGPoint(x: pointFour.x + largeSpace * scaleMuseum, y: pointFour.y))
//        pathWalls.addLine(to: CGPoint(x: pointThree.x + smallSpace * scaleMuseum, y: pointThree.y))
//        
//        pathWalls.move(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace) * scaleMuseum , y: pointThree.y))
//        pathWalls.addLine(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace) * scaleMuseum, y: pointFour.y))
//        
//        pathWalls.move(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointFour.y))
//        pathWalls.addLine(to:CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointThree.y))
//        
//        pathWalls.move(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointThree.y))
//        pathWalls.addLine(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointFour.y))
//
//        pathWalls.move(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointFour.y))
//        pathWalls.addLine(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointThree.y))
//
//        pathWalls.move(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointThree.y))
//        pathWalls.addLine(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointFour.y))
//
//        pathWalls.move(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointFour.y))
//        pathWalls.addLine(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointThree.y))
//
//        pathWalls.move(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointThree.y))
//        pathWalls.addLine(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointFour.y))
//
//        pathWalls.move(to: CGPoint(x: pointFour.x + (largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace) * scaleMuseum, y: pointFour.y))
//        pathWalls.addLine(to: CGPoint(x: pointThree.x + (smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace + largeSpace + smallSpace) * scaleMuseum, y: pointThree.y))
//        pathWalls.stroke()
//        
//        // Draw foundation
//        let pathSquareTwo = UIBezierPath(rect: CGRect(x: pointFour.x - 1 * scaleMuseum, y: pointFour.y, width: squareTwoWidth * scaleMuseum, height: squaresHeight * scaleMuseum))
//      
//        pathSquareTwo.stroke()
//        let pathSquareThree = UIBezierPath(rect: CGRect(x: pointFour.x - 4 * scaleMuseum, y: pointFour.y + 5 * scaleMuseum, width: squareThreeWidth * scaleMuseum, height: squaresHeight * scaleMuseum))
//        
//        pathSquareThree.stroke()
//
//    }
}
