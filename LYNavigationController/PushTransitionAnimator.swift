//
//  PushTransitionAnimator.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/1.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

public class PushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var shadowView: UIView!
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.5
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let containerView = transitionContext.containerView()
        
        let fromControl = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toControl = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        shadowView = UIView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        shadowView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
        fromControl.view.addSubview(shadowView)
        
        containerView?.insertSubview(toControl.view, aboveSubview: fromControl.view)
        
        toControl.view.frame = CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height)
        
        toControl.view.layer.shadowColor = UIColor.blackColor().CGColor
        toControl.view.layer.shadowOpacity = 0.8
        toControl.view.layer.shadowRadius = 8
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { [weak self] () -> Void in
            
            self?.shadowView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
            fromControl.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            toControl.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
            }) { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                // 这里不能用weak self 会导致阴影无法移除
                self.shadowView.removeFromSuperview()
        }
        
    }
    
}
