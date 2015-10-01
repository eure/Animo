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
    
    // MARK: Public
    
    public var baseDuration: NSTimeInterval {
        
        let object = self.object
        let rawDuration = object.duration
        return object.autoreverses ? (rawDuration * 2.0) : rawDuration
    }
    
    public var accumulatedDuration: NSTimeInterval {
        
        let object = self.object
        switch (object.repeatCount, object.repeatDuration) {
            
        case (let repeatCount, 0) where repeatCount > 0:
            return NSTimeInterval(repeatCount) * self.baseDuration
            
        case (Float.infinity, 0):
            return .infinity
            
        case (0, let repeatDuration) where repeatDuration > 0:
            return repeatDuration // TODO: check for autoreverses?
            
        default:
            return self.baseDuration
        }
    }
    
    
    // MARK: Internal
    
    internal let object: CAAnimation
    
    internal init(_ object: CAAnimation) {
        
        self.object = object
    }
}
