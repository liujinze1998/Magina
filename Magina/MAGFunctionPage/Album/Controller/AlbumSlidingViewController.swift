//
//  AlbumSlidingViewController.swift
//  Magina
//
//  Created by AM on 2024/3/8.
//

import Foundation
import UIKit

class AlbumSlidingViewController: UIViewController {
    var titles: [String]//for UIButton
    var slidingTab : AlbumSlidingTabView?
    var viewControllers: [AlbumCategoryViewController] = []
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: view.bounds)
        view.isScrollEnabled = true
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        view.delegate = self
        return view
    }()
    
    var selectedIndex: Int {
        didSet(value) {
            scrollToIndex(index: selectedIndex)
        }
    }
    
    
    init(titles: [String], selectedIndex: Int) {
        self.titles = titles
        let indexRange = 0..<titles.count
        if indexRange.contains(selectedIndex) {
            self.selectedIndex = selectedIndex
        } else {
            self.selectedIndex = 0
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        self.updateScrollContentSize()
    }
}

extension AlbumSlidingViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let velocity : CGPoint = scrollView.panGestureRecognizer.velocity(in: scrollView.superview)
        var nextIndex : Int =  Int(round(scrollView.contentOffset.x / scrollView.bounds.size.width));
        if (velocity.x < 0) {
            nextIndex += 1
        } else {
            nextIndex -= 1
        }
        if nextIndex >= 0 && nextIndex < viewControllers.count {
            selectedIndex = nextIndex
            slidingTab?.selectedIndex = nextIndex
        }
    }
    
    func scrollToIndex(index:Int)
    {
        let count = viewControllers.count
        if (index < 0 || index >= count) {
            return;
        }
        let targetOffset = scrollView.bounds.size.width * CGFloat(index)
        scrollView.setContentOffset(CGPoint(x: targetOffset, y: scrollView.contentOffset.y), animated: true)
    }

}

extension AlbumSlidingViewController {
    func addViewController(vc: AlbumCategoryViewController) {
        viewControllers.append(vc)
        self.addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        vc.didMove(toParent: self)
        scrollView.addSubview(vc.view)
        self.updateScrollContentSize()
    }
    
    func updateCategoryVCFrame(){
        var num = 0
        for vc in viewControllers {
            vc.view.frame = CGRect(x: CGFloat(num) * self.view.bounds.size.width, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            vc.updateCollectionFrame()
            num = num + 1
        }
    }
    
    func reverseDataSource(){
        for vc in viewControllers {
            vc.reverseData()
        }
    }
    
    func reloadViewControllers(){
        for vc in viewControllers {
            vc.reloadData()
        }
    }
    
    func reloadViewControllerWith(id: String, container: CategoryDataSource) {
        for vc in viewControllers {
            if (vc.categoryID == id) {
                vc.reloadCategoryData(container)
            }
        }
    }
    
    func updateScrollContentSize() {
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * CGFloat(viewControllers.count), 0)
    }
}
