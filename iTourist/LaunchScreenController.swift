//
//  ViewController.swift
//  testCoreGraphics
//
//  Created by Kristina Del Rio Albrechet on 8/18/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var planetView: PlanetView!
    @IBOutlet weak var planeView: PlaneView!
    
    var animatedFly: CABasicAnimation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        runSpinAnimationOn(view: planeView, duration: 3, rotation: 1, repeats: 1)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardController") as? DashboardController {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func runSpinAnimationOn(view: UIView, duration: Double, rotation: Double, repeats: Float) {
        animatedFly = CABasicAnimation(keyPath: "transform.rotation.z")
        animatedFly?.delegate = self
        if let animation = animatedFly {
            animation.toValue = NSNumber(value: Double.pi * 2.0 * rotation)
            animation.duration = duration
            animation.isCumulative = true
            animation.repeatCount = repeats
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            view.layer.add(animation, forKey: "rotationAnimation")
        }
    }
}
