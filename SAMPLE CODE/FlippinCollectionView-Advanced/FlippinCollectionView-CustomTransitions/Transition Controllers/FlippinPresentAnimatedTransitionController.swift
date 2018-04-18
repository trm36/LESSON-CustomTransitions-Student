//
//  FlippinPresentAnimatedTransitionController.swift
//  FlippinCollectionView-CustomTransitions
//
//  Created by Taylor Mott on 04-Oct-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class FlippinPresentAnimatedTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let collectionViewController = transitionContext.viewController(forKey: .from) as? FlippinCollectionViewController,
            let detailViewController = transitionContext.viewController(forKey: .to) as? DetailViewController,
            let collectionView = collectionViewController.collectionView,
            let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
            let selectedIndexPath = selectedIndexPaths.first,
            let cell = collectionView.cellForItem(at: selectedIndexPath),
            let detailViewSnapshot = detailViewController.view.snapshotView(afterScreenUpdates: true) else { return }
        
        let cellFrame = collectionView.convert(cell.frame, to: collectionViewController.view)
        detailViewSnapshot.frame = cellFrame
        
        let containerView = transitionContext.containerView
        containerView.addSubview(detailViewController.view)
        containerView.addSubview(detailViewSnapshot)
        containerView.backgroundColor = collectionView.backgroundColor
        detailViewController.view.isHidden = true
        
        detailViewSnapshot.layer.transform = CATransform3D.makeYRotation(yAngleDegrees: 90.0)
        
        let duration = transitionDuration(using: transitionContext)
        
        let keyframeAnimation0 = {
            collectionViewController.view.layer.transform = CATransform3D.makeYRotation(yAngleDegrees: -90.0)
        }
        let keyframeAnimation1 = {
            detailViewSnapshot.layer.transform = CATransform3D.makeYRotation(yAngleDegrees: 0.0)
        }
        let keyframeAnimation2 = {
            detailViewSnapshot.frame = transitionContext.finalFrame(for: detailViewController)
        }
        
        animateTransitionEvenly(with: duration,
            keyframeAnimations: [keyframeAnimation0, keyframeAnimation1, keyframeAnimation2],
                    completion: { (complete: Bool) in
                            detailViewController.view.isHidden = false
                            detailViewSnapshot.removeFromSuperview()
                            transitionContext.completeTransition(complete)
        })
    }
    
    
    func animateTransitionEvenly(with duration: TimeInterval, keyframeAnimations: [() -> Void], completion: @escaping (Bool) -> Void) {
        
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
