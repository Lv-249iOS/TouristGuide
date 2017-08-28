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
        let lineWidth: CGFloat = 2.0
        let kWidthMutiplier: CGFloat = 9.0
        let kHeightMutiplier: CGFloat = 7.0
        let kSideOffset: CGFloat = 20.0
        let kvadratikHeight: CGFloat = 6.0
        let kBottomLayerHeight: CGFloat = 8.0
        var buildingWidth: CGFloat = 0.0
        var buildingHeight: CGFloat = 0.0
        
        if width > height {
            buildingHeight = height - kSideOffset * 2
            buildingWidth = buildingHeight / kHeightMutiplier * kWidthMutiplier
        } else {
            buildingWidth = width - kSideOffset * 2
            buildingHeight = buildingWidth / kWidthMutiplier * kHeightMutiplier
        }
        
        let startX = width / 2.0
        let startY = (height / 2.0) - (buildingHeight / 2.0)
        let startPoint = CGPoint(x: startX, y: startY)
       
        // Draw roof
        let pathRoof = UIBezierPath()
        pathRoof.lineWidth = lineWidth
        pathRoof.move(to: startPoint)
        let point1 = CGPoint(x: startX - buildingWidth / 2, y: startY + buildingHeight / kHeightMutiplier)
        pathRoof.addLine(to: point1)
        let point2 = CGPoint(x: point1.x + buildingWidth, y: point1.y)
        pathRoof.addLine(to: point2)
        pathRoof.close()
        UIColor.purple.setStroke()
        pathRoof.stroke()
        let kvadratikRect = CGRect(x: point1.x, y: point1.y, width: buildingWidth, height: kvadratikHeight)
        let squareUnderTheRoof = UIBezierPath(rect: kvadratikRect)
        squareUnderTheRoof.lineWidth = lineWidth
        UIColor.purple.setStroke()
        squareUnderTheRoof.stroke()
        
        // Top collumn points
        let numberOfCollumns: CGFloat = 5
        var freeSpace = buildingWidth - buildingWidth / 15.0 * numberOfCollumns
        var collumnStartY = kvadratikRect.origin.y + kvadratikRect.size.height
        var collumnStartX = point1.x + buildingWidth / 15.0
        var topPoints: [CGPoint] = []
        
        for i in 0..<10 {
            let point = CGPoint(x: collumnStartX, y: collumnStartY)
            topPoints.append(point)
            collumnStartX += (i % 2) != 0 ? freeSpace / 5.0 : buildingWidth / 15.0
        }
        
        // Bottom collumn points
        let spacingOfBottomCollumns = buildingWidth / 7.0
        collumnStartY = height / 2 + buildingHeight / 2 - kBottomLayerHeight * 2
        collumnStartX = point1.x + 5.5
        freeSpace = (buildingWidth - 4) - spacingOfBottomCollumns * numberOfCollumns
        
        var bottomPoints: [CGPoint] = []
        
        for i in 0..<10 {
            let point = CGPoint(x: collumnStartX, y: collumnStartY)
            bottomPoints.append(point)
            collumnStartX += (i % 2) != 0 ? freeSpace / 5.0 : spacingOfBottomCollumns
        }
        
        // Connect
        for i in 0..<topPoints.count {
            let pathCollumn = UIBezierPath()
            pathCollumn.lineWidth = lineWidth
            pathCollumn.move(to: topPoints[i])
            pathCollumn.addLine(to: bottomPoints[i])
            pathCollumn.stroke()
        }
        
        // Foundation
        let kvadratikRect2 = CGRect(x: point1.x, y: collumnStartY, width: buildingWidth, height: kBottomLayerHeight)
        let squareAtBottom1 = UIBezierPath(rect: kvadratikRect2)
        squareAtBottom1.lineWidth = lineWidth
        UIColor.purple.setStroke()
        squareAtBottom1.stroke()
        let kvadratikRect3 = CGRect(x: point1.x - 6.0, y: collumnStartY + kBottomLayerHeight, width: buildingWidth + 12.0, height: kBottomLayerHeight)
        let squareAtBottom2 = UIBezierPath(rect: kvadratikRect3)
        squareAtBottom2.lineWidth = lineWidth
        UIColor.purple.setStroke()
        squareAtBottom2.stroke()
    }
}
