//
//  PlacesPageController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/7/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlacesPageController: UIPageViewController {
    var imagesStringUrl: [String]?
    var images: [UIImage] = []
    var imageLoader = ImageDownloader.shared
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return self.newColoredViewController(imagess: self.images)
    }()
    
    private func newColoredViewController(imagess: [UIImage]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        for img in imagess {
            let viewController = UIStoryboard(name: "PlacesType", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            viewController.image = img
            viewControllers.append(viewController)
        }
        return viewControllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self        
        guard let paths = imagesStringUrl else { return }
        for path in paths {
            imageLoader.obtainImage(with: path) { image in
                self.images.append(image)
            }
        }
        /*if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }*/
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
