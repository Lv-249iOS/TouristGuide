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
        
        // Constants for museum
        let width = bounds.width
        let height = bounds.height
        let lineWidth: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 3.5 : 2.0
        let kWidthMutiplier: CGFloat = 9.0
        let kHeightMutiplier: CGFloat = 9.0
        let kSideOffset: CGFloat = 20.0
        let kvadratikHeight: CGFloat = 6.0
        let kBottomLayerHeight: CGFloat = 8.0
        
        var buildingWidth: CGFloat = 0.0
        var buildingHeight: CGFloat = 0.0
        
        // Check for device orientation
        if width > height {
            buildingHeight = height - kSideOffset * 2
            buildingWidth = buildingHeight / kHeightMutiplier * kWidthMutiplier
        } else {
            buildingWidth = width - kSideOffset * 2
            buildingHeight = buildingWidth / kWidthMutiplier * kHeightMutiplier
        }
        
        // Start point for drawing
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
        
        // Draw squre under the roof
        let squreRect = CGRect(x: point1.x, y: point1.y, width: buildingWidth, height: kvadratikHeight)
        let squareUnderTheRoof = UIBezierPath(rect: squreRect)
        squareUnderTheRoof.lineWidth = lineWidth
        UIColor.purple.setStroke()
        squareUnderTheRoof.stroke()
        
        // Top collumn points
        let numberOfCollumns: CGFloat = 5
        let freeSpace = buildingWidth - buildingWidth / 15.0 * numberOfCollumns
        
        var collumnStartY = squreRect.origin.y + squreRect.size.height
        var collumnStartX = point1.x + buildingWidth / 15.0
        
        var topPoints: [CGPoint] = []
        
        // Spacing of top
        for i in 0..<10 {
            let point = CGPoint(x: collumnStartX, y: collumnStartY)
            topPoints.append(point)
            collumnStartX += (i % 2) != 0 ? freeSpace / 5.0 : buildingWidth / 15.0
        }
        
        // Bottom collumn points
        collumnStartY = height / 2 + buildingHeight / 2 - kBottomLayerHeight * 2
        collumnStartX = point1.x + (buildingWidth / 15.0) / 2
        
        var bottomPoints: [CGPoint] = []
        
        // Spacing of bottom
        for i in 0..<10 {
            let point = CGPoint(x: collumnStartX, y: collumnStartY)
            bottomPoints.append(point)
            collumnStartX += (i % 2) != 0 ? buildingWidth / 15.0 : freeSpace / 5.0
        }
        
        // Connect top and bottom points
        for i in 0..<topPoints.count {
            let pathCollumn = UIBezierPath()
            pathCollumn.lineWidth = lineWidth
            pathCollumn.move(to: topPoints[i])
            pathCollumn.addLine(to: bottomPoints[i])
            pathCollumn.stroke()
        }
        
        // Foundation of museum
        let squreRectTwo = CGRect(x: point1.x, y: collumnStartY, width: buildingWidth, height: kBottomLayerHeight)
        let squareAtBottom1 = UIBezierPath(rect: squreRectTwo)
        squareAtBottom1.lineWidth = lineWidth
        UIColor.purple.setStroke()
        squareAtBottom1.stroke()
        
        let squreThree = CGRect(x: point1.x - 6.0, y: collumnStartY + kBottomLayerHeight, width: buildingWidth + 12.0, height: kBottomLayerHeight)
        let squareAtBottom2 = UIBezierPath(rect: squreThree)
        squareAtBottom2.lineWidth = lineWidth
        UIColor.purple.setStroke()
        squareAtBottom2.stroke()
    }
}

