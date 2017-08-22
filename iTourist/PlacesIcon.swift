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
        // Draw spike
        let pathSpike = UIBezierPath()
        pathSpike.lineWidth = 1
        pathSpike.move(to: CGPoint(x: bounds.midX, y: bounds.minY ))
        let pointSpike = CGPoint(x: bounds.midX, y: bounds.minY + 7 )
        pathSpike.addLine(to:pointSpike)
        UIColor.purple.setStroke()
        pathSpike.stroke()
        
        // Draw roof
        let pathRoof = UIBezierPath()
        pathRoof.move(to: pointSpike)
        let pointOne = CGPoint(x: pointSpike.x - 30, y: pointSpike.y + 20)
        pathRoof.addLine(to: pointOne)
        
        let pointTwo = CGPoint(x: pointOne.x + 58, y: pointOne.y)
        pathRoof.addLine(to: pointTwo)
        pathRoof.close()
        pathRoof.stroke()
        
        // Draw square under the roof
        let pathSquare = UIBezierPath(rect: CGRect(x: pointOne.x, y: pointOne.y, width: 58, height: 5))
        pathSquare.stroke()
        
        // Draw colomns
        let pathWalls = UIBezierPath()
        
        let pointThree = CGPoint(x: pointOne.x + 3, y: pointOne.y + 5)
        pathWalls.move(to: pointThree)
        
        let pointFour = CGPoint(x: pointThree.x - 2, y: pointThree.y + 45)
        pathWalls.addLine(to: pointFour)
        
        pathWalls.move(to: CGPoint(x: pointFour.x + 8, y: pointFour.y))
        pathWalls.addLine(to: CGPoint(x: pointThree.x + 4, y: pointThree.y))
        
        pathWalls.move(to: CGPoint(x: pointThree.x + 12, y: pointThree.y))
        pathWalls.addLine(to: CGPoint(x: pointFour.x + 12, y: pointFour.y))
        
        pathWalls.move(to: CGPoint(x: pointFour.x + 20, y: pointFour.y))
        pathWalls.addLine(to:CGPoint(x: pointThree.x + 16, y: pointThree.y))
        
        pathWalls.move(to: CGPoint(x: pointThree.x + 24, y: pointThree.y))
        pathWalls.addLine(to: CGPoint(x: pointFour.x + 24, y: pointFour.y))
        
        pathWalls.move(to: CGPoint(x: pointFour.x + 32, y: pointFour.y))
        pathWalls.addLine(to: CGPoint(x: pointThree.x + 28, y: pointThree.y))
        
        pathWalls.move(to: CGPoint(x: pointThree.x + 36, y: pointThree.y))
        pathWalls.addLine(to: CGPoint(x: pointFour.x + 36, y: pointFour.y))
        
        pathWalls.move(to: CGPoint(x: pointFour.x + 44, y: pointFour.y))
        pathWalls.addLine(to: CGPoint(x: pointThree.x + 40, y: pointThree.y))
        
        pathWalls.move(to: CGPoint(x: pointThree.x + 48, y: pointThree.y))
        pathWalls.addLine(to: CGPoint(x: pointFour.x + 48, y: pointFour.y))
        
        pathWalls.move(to: CGPoint(x: pointFour.x + 56, y: pointFour.y))
        pathWalls.addLine(to: CGPoint(x: pointThree.x + 52, y: pointThree.y))
        pathWalls.stroke()
        
        // Draw foundation
        let pathSquareTwo = UIBezierPath(rect: CGRect(x: pointFour.x - 1, y: pointFour.y, width: 58, height: 5))
        pathSquareTwo.stroke()
        let pathSquareThree = UIBezierPath(rect: CGRect(x: pointFour.x - 4, y: pointFour.y + 5, width: 64, height: 5))
        pathSquareThree.stroke()
    }
}
