//
//  PopTransitionAnimator.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/1.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

open class PopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var shadowView: UIView!
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.3
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let screenSize = UIScreen.main.bounds.size
        
        let containerView = transitionContext.containerView
        
        let fromControl = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toControl = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        shadowView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toControl.view.addSubview(shadowView)
        
        containerView.insertSubview(toControl.view, belowSubview: fromControl.view)
        
        toControl.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        fromControl.view.layer.shadowColor = UIColor.black.cgColor
        fromControl.view.layer.shadowOpacity = 0.8
        fromControl.view.layer.shadowRadius = 8
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { [weak self] () -> Void in
            
            self?.shadowView.backgroundColor = UIColor.black.withAlphaComponent(0)
            fromControl.view.frame = CGRect(x: screenSize.width, y: 0, width: screenSize.width, height: screenSize.height)
            toControl.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                // 这里不能用weak self 会导致阴影无法移除
                self.shadowView.removeFromSuperview()
                
        }) 
        
    }
    
}
