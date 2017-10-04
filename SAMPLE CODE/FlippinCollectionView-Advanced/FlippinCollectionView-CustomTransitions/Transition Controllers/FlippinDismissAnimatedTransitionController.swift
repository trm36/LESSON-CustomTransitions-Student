//
//  FlippinDismissAnimatedTransitionController.swift
//  FlippinCollectionView-CustomTransitions
//
//  Created by Taylor Mott on 04-Oct-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class FlippinDismissAnimatedTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let detailViewController = transitionContext.viewController(forKey: .from) as? DetailViewController,
            let collectionViewController = transitionContext.viewController(forKey: .to) as? FlippinCollectionViewController,
            let detailViewSnapshot = detailViewController.view.snapshotView(afterScreenUpdates: false) else { return }
        
        let viewCenter = collectionViewController.view.center
        let finalFrame = CGRect(x: viewCenter.x - (FlippinCollectionViewController.cellDimension/2.0),
                                y: viewCenter.y - (FlippinCollectionViewController.cellDimension/2.0),
                                width: FlippinCollectionViewController.cellDimension,
                                height: FlippinCollectionViewController.cellDimension)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(collectionViewController.view)
        containerView.addSubview(detailViewSnapshot)
        detailViewController.view.isHidden = true
        
        collectionViewController.view.layer.transform = CATransform3D.makeYRotation(yAngleDegrees: -90.0)
        
        let duration = transitionDuration(using: transitionContext)
        
        let keyframeAnimation0 = {
            detailViewSnapshot.frame = finalFrame
        }
        let keyframeAnimation1 = {
            detailViewSnapshot.layer.transform = CATransform3D.makeYRotation(yAngleDegrees: 90.0)
        }
        let keyframeAnimation2 = {
            collectionViewController.view.layer.transform = CATransform3D.makeYRotation(yAngleDegrees:  0.0)
        }

        dismissAnimations(with: duration,
                          keyframeAnimations: [keyframeAnimation0, keyframeAnimation1, keyframeAnimation2],
                          completion: { (complete: Bool) in
                            detailViewController.view.isHidden = true
                            detailViewSnapshot.removeFromSuperview()
                            transitionContext.completeTransition(complete)
        })
        
    }
    
    func dismissAnimations(with duration: TimeInterval, keyframeAnimations: [() -> Void], completion: @escaping (Bool) -> Void) {
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0.0,
                                options: .calculationModeCubic,
                                animations: {
                                    for index in 0..<keyframeAnimations.count {
                                        let countAsDouble = Double(keyframeAnimations.count)
                                        let indexAsDouble = Double(index)
                                        UIView.addKeyframe(withRelativeStartTime: indexAsDouble / countAsDouble,
                                                           relativeDuration: 1.0 / countAsDouble,
                                                           animations: keyframeAnimations[index])
                                    }
                                },
                                completion: completion)
    }
    
    
}
