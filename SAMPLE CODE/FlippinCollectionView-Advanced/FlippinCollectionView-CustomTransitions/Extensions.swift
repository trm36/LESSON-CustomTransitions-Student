//
//  Extensions.swift
//  FlippinCollectionView-CustomTransitions
//
//  Created by Taylor Mott on 04-Oct-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

extension CATransform3D {
    static func makeYRotation(yAngleDegrees: Double) -> CATransform3D {
        
        let yAngleRadians = yAngleDegrees * .pi / 180.0
        
        print("DEG \(yAngleDegrees)")
        print("RED \(yAngleRadians)")
        
        return CATransform3DMakeRotation(CGFloat(yAngleRadians), 0.0, 1.0, 0.0)
    }
}
