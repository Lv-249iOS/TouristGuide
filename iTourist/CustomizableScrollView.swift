//
//  CustomizableScrollView.swift
//  iTourist
//
//  Created by Yaroslav Luchyt on 8/17/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableScrollView: UIScrollView {

    @IBInspectable var contentsSize: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.contentsRect.size = contentsSize
        }
    }
}
