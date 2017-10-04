//
//  DismissAnimationController.swift
//  CustomTransition
//
//  Created by Taylor Mott on 2/15/17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//


import UIKit

class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning  {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let finalFrameForToVC = transitionContext.finalFrame(for: toViewController)
        let finalFrameForFromVC = CGRect(x: 0, y: -fromViewController.view.frame.height, width: fromViewController.view.frame.width, height: fromViewController.view.frame.height)
        
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForToVC.offsetBy(dx: 0, dy: toViewController.view.frame.height)
        containerView.addSubview(toViewController.view)
        
        let toNavigationController = toViewController as! UINavigationController
        let navigationBar = toNavigationController.navigationBar
        let navigationBarFrame = navigationBar.frame
        navigationBar.frame = CGRect(x: navigationBarFrame.origin.x,
                                     y: navigationBarFrame.origin.y,
                                 width: navigationBarFrame.size.width,
                                height: navigationBarFrame.size.height + 20)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            fromViewController.view.frame = finalFrameForFromVC
            toViewController.view.frame = finalFrameForToVC
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(true)
        }) 
        
    }
}

