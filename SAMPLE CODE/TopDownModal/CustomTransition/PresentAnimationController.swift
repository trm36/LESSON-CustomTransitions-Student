//
//  PresentAnimationController.swift
//  CustomTransition
//
//  Created by Taylor Mott on 2/15/17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//


import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let bounds = UIScreen.main.bounds
        
        let finalFrameForToVC = transitionContext.finalFrame(for: toViewController)
        let finalFrameForFromVC = CGRect(x: 0, y: bounds.size.height, width: bounds.size.width, height: bounds.size.height)
        
        
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForToVC.offsetBy(dx: 0, dy: -(bounds.size.height))
        containerView.addSubview(toViewController.view)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            fromViewController.view.frame = finalFrameForFromVC
            toViewController.view.frame = finalFrameForToVC
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(true)
        }) 
        
    }

}
