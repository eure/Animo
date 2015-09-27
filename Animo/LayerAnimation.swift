//
//  LayerAnimation.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/25.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import QuartzCore


// MARK: - LayerAnimation

public struct LayerAnimation {
    
    // MARK: Internal
    
    internal var accumulatedDuration: NSTimeInterval {
        
        let object = self.object
        return object.autoreverses
            ? object.duration * 2.0
            : object.duration
    }
    
    internal let object: CAAnimation
    
    internal init(_ object: CAAnimation) {
        
        self.object = object
    }
}
