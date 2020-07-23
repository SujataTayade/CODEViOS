//
//  MultiPageViewController.swift
//  CODEViOS
//
//  Created by Sujata Tayade on 30/06/20.
//  Copyright © 2020 Sujata Tayade. All rights reserved.
//

import UIKit

class MultiPageViewController: UIPageViewController {

    
    lazy var items: [UIViewController] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        decoratePageControl()
        
        populateItems()
//        items = []
//        items = [ViewController1(), ViewController2()]
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
        self.dataSource = self
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [MultiPageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    fileprivate func populateItems() {
//        let text = ["🎖", "👑", "🥇"]
//        let backgroundColor:[UIColor] = [.blue, .red, .green]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController: ViewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController1") as! ViewController1
        items.append(firstViewController)
        let SecondViewController: ViewController2 = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        items.append(SecondViewController)
    }
    
}

// MARK: - DataSource

extension MultiPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
