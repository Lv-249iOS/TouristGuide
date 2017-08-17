//
//  PlacesPageController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/7/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlacesPageController: UIPageViewController {
    
    var imagesStringUrl: [String] = []
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return self.newColoredViewController(imagesStringUrl: self.imagesStringUrl)
    }()
    
    /// Here we create viewControllers for every picture equals every page of pageViewController
    private func newColoredViewController(imagesStringUrl: [String]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        for url in imagesStringUrl {
            let viewController = UIStoryboard(name: "PlacesType", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            viewController.imageUrlString = url
            viewControllers.append(viewController)
        }
        
        return viewControllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

/// We need extension to provide pageViewController for this class
extension PlacesPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0, orderedViewControllers.count > previousIndex else { return nil}
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex, orderedViewControllersCount > nextIndex else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else { return 0 }
        
        return firstViewControllerIndex
    }
}
