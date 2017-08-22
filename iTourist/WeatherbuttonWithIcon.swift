//
//  WeatherbuttonWithIcon.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/21/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class WeatherbuttonWithIcon: RoundButton {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        var radius: Double = 0.0
        radius = Double(rect.width/3)
        
        //radius = Double(rect.height/2 - 10)
        
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y ))
        for i in stride(from: 0, to: 361.0, by: 10) {
            
            let radians = i * Double.pi / 180
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
            path.addLine(to: CGPoint(x: x, y: y))
            
        }
        path.lineWidth = 5
        UIColor.orange.setStroke()
        path.stroke()
        
    }
}
