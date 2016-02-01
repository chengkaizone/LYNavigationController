//
//  LYNavigationController.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/1.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

public class LYNavigationController: UINavigationController {
    
    public var percentInteractiveTransition: UIPercentDrivenInteractiveTransition!
    // public var interactivePopGestureRecognizerType: Interactive
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.hidden = true
        self.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        setupGesture()
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: "panGesture:")
        self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(panGesture)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func panGesture(gesture: UIPanGestureRecognizer) {
        
        let point = gesture.translationInView(gesture.view)
        let progress = point.x / gesture.view!.bounds.size.width
        
        switch gesture.state {
        case .Began:
            self.percentInteractiveTransition = UIPercentDrivenInteractiveTransition()
            self.popViewControllerAnimated(true)
            break
        case .Changed, .Possible:
            self.percentInteractiveTransition.updateInteractiveTransition(progress)
            break
        case .Cancelled, .Ended, .Failed:
            
            if progress > 0.5 {
                self.percentInteractiveTransition.finishInteractiveTransition()
            } else {
                self.percentInteractiveTransition.cancelInteractiveTransition()
            }
            self.percentInteractiveTransition = nil
            break
        }
        
    }

}

extension LYNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController.isKindOfClass(PopTransitionAnimator.self) {
            return self.percentInteractiveTransition
        }
        
        return nil
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .Push {
            
            return PushTransitionAnimator()
        } else if operation == .Pop {
            
            return PopTransitionAnimator()
        }
        
        return nil
    }
    
}

extension LYNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count > 1 {
            return true
        }
        
        return false
    }
    
}
