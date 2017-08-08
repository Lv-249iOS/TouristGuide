//
//  ResizerOfUIImage.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeImage(sizeChange:CGSize)-> UIImage {
        let ignoreAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, ignoreAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        guard let scaledImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        
        return scaledImage
    }
    
}
