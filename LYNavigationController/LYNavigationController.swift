//
//  LYNavigationController.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/1.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

open class LYNavigationController: UINavigationController {
    
    open var percentInteractiveTransition: UIPercentDrivenInteractiveTransition!
    
    open var lyNavigationBar: LYNavigationBar!
    open var lyNavigationBarHidden: Bool = false {
        didSet {
            self.lyNavigationBar.isHidden = lyNavigationBarHidden
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isHidden = true
        self.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.lyNavigationBar = LYNavigationBar(frame: CGRect.zero)
        self.topViewController?.view.addSubview(lyNavigationBar)
        self.lyNavigationBar.title = "Push"
        
        self.lyNavigationBar.isHidden = lyNavigationBarHidden
        
        setupGesture()
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(LYNavigationController.panGesture(_:)))
        self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(panGesture)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let naviBar = LYNavigationBar(frame: CGRect.zero)
        
        viewController.view.addSubview(naviBar)
        naviBar.title = viewController.title
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func panGesture(_ gesture: UIPanGestureRecognizer) {
        
        let point = gesture.translation(in: gesture.view)
        let progress = point.x / gesture.view!.bounds.size.width
    
        switch gesture.state {
        case .began:
            self.percentInteractiveTransition = UIPercentDrivenInteractiveTransition()
            self.popViewController(animated: true)
            break
        case .changed, .possible:
            if point.x <= 0 {
                self.percentInteractiveTransition.update(0)
            } else {
                
                let value = abs(point.y)
                if point.x < value {
                    self.percentInteractiveTransition.update(0)
                } else {
                    self.percentInteractiveTransition.update(progress)
                }
            }
            break
        case .cancelled, .ended, .failed:
            
            if progress > 0.5 {
                self.percentInteractiveTransition.finish()
            } else {
                self.percentInteractiveTransition.cancel()
            }
            self.percentInteractiveTransition = nil
            break
        }
        
    }

}

extension LYNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController.isKind(of: PopTransitionAnimator.self) {
            return self.percentInteractiveTransition
        }
        
        return nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            
            return PushTransitionAnimator()
        } else if operation == .pop {
            
            return PopTransitionAnimator()
        }
        
        return nil
    }
    
}

extension LYNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count > 1 {
            return true
        }
        
        return false
    }
    
}
