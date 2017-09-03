//
//  File.swift
//  testCoreGraphics
//
//  Created by Kristina Del Rio Albrechet on 8/21/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

typealias Degrees = Double
typealias Radians = CGFloat

class DegreesConverter {
    
    /// Converts degrees to radians
    static func radians(from degrees: Degrees) -> Radians {
        return CGFloat(degrees) * CGFloat.pi / 180
    }
    
    /// Returns point in the circle line
    static func pointOnCircle(with radius: CGFloat, from centerPosition: CGPoint, angle: CGFloat) -> CGPoint {
        let point = CGPoint(x: Double(centerPosition.x) + Double(radius) * cos(Double(angle)),
                            y: Double(centerPosition.y) + Double(radius) * sin(Double(angle)))
        
        return point
    }
}
