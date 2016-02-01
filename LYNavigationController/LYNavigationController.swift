//
//  LYNavigationController.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/1.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

public class LYNavigationController: UINavigationController {
    
    public var interactiveTransition: UIPercentDrivenInteractiveTransition!
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
        
        let state = gesture.state
        
        if state == .Began {
            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.popViewControllerAnimated(true)
        } else if state == .Changed {
            self.interactiveTransition.updateInteractiveTransition(progress)
        } else if state == .Cancelled || state == .Ended {
            if progress > 0.5 {
                self.interactiveTransition.finishInteractiveTransition()
            } else {
                self.interactiveTransition.cancelInteractiveTransition()
            }
            self.interactiveTransition = nil
        }
//        switch gesture.state {
//        case .Began:
//            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
//            self.popViewControllerAnimated(true)
//            break
//        case .Changed, .Possible:
//            self.interactiveTransition.updateInteractiveTransition(progress)
//            break
//        case .Cancelled, .Ended, .Failed:
//            
//            if progress > 0.5 {
//                self.interactiveTransition.finishInteractiveTransition()
//            } else {
//                self.interactiveTransition.cancelInteractiveTransition()
//            }
//            self.interactiveTransition = nil
//            break
//        }
        
    }

}

extension LYNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController.isKindOfClass(PopTransitionAnimator.self) {
            return self.interactiveTransition
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
