//
//  PlacesPageController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/7/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlacesPageController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background")),
            self.newColoredViewController(image: #imageLiteral(resourceName: "background"))
        ]
    }()
    
    private func newColoredViewController(image: UIImage?) -> UIViewController {
        let viewController = UIStoryboard(name: "PlacesType", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        viewController.image = image
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

extension PlacesPageController: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
         return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
