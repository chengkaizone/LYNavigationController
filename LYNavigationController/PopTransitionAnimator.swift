//
//  PopTransitionAnimator.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/1.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

class PopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let containerView = transitionContext.containerView()
        
        let fromControl = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toControl = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        containerView?.insertSubview(toControl.view, belowSubview: fromControl.view)
        
        toControl.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
        
        fromControl.view.layer.shadowColor = UIColor.blackColor().CGColor
        fromControl.view.layer.shadowOpacity = 0.8
        fromControl.view.layer.shadowRadius = 0
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            
            fromControl.view.frame = CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height)
            toControl.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
        }
        
    }
    
    func animationEnded(transitionCompleted: Bool) {
        
    }
    
}
