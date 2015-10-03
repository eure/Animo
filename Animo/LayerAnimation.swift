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
    
    public func repeatBy(count: Int) -> LayerAnimation {
        
        return Options().applyTo(repetition: self, count: count)
    }
    
    public func repeatForever() -> LayerAnimation {
        
        return Options().applyTo(repetition: self)
    }
    
    public func autoreverse() -> LayerAnimation {
        
        return Options().applyTo(autoreverse: self)
    }
    
    // MARK: Internal
    
    internal let object: CAAnimation
    internal let baseDuration: NSTimeInterval
    internal let accumulatedDuration: NSTimeInterval
    
    internal init(_ object: CAAnimation, baseDuration: NSTimeInterval, accumulatedDuration: NSTimeInterval) {
        
        self.object = object
        self.baseDuration = baseDuration
        self.accumulatedDuration = accumulatedDuration
    }
}
