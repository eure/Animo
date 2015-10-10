//
//  CALayer+Animo.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CALayer

public extension CALayer {
    
    // MARK: Public
    
    public func runAnimation(animation: LayerAnimation, forKey key: String = NSUUID().UUIDString) -> String {
        
        self.addAnimation(animation.copyObject(), forKey: key)
        return key
    }
    
    public func runAnimation(animation: LayerAnimation, forKey key: String = NSUUID().UUIDString, completion: () -> Void) -> String {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.addAnimation(animation.copyObject(), forKey: key)
        CATransaction.commit()
        return key
    }
    
    public func pauseAnimations() {
        
        self.speed = 0
        self.timeOffset = self.convertTime(CACurrentMediaTime(), fromLayer: nil)
    }
    
    public func resumeAnimations() {
        
        self.resumeAnimationsAtSpeed(1)
    }
    
    public func resumeAnimationsAtSpeed(newSpeed: Float) {
        
        let pausedTime = self.timeOffset
        
        guard pausedTime != 0 else {
            
            let currentTime = CACurrentMediaTime()
            self.timeOffset = self.convertTime(currentTime, fromLayer: nil)
            self.beginTime = currentTime
            self.speed = newSpeed
            return
        }
        
        self.speed = newSpeed
        self.timeOffset = 0
        self.beginTime = 0
        
        let elapsedTime = self.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        self.beginTime = elapsedTime
    }
    
    public func runTransition(type: Transition = .Fade, duration: NSTimeInterval = 0, timingMode: TimingMode = .Linear, options: Options = .Default) {
        
        let transition = CATransition()
        type.applyTo(transition)
        transition.duration = duration
        transition.applyOptions(options)
        
        self.addAnimation(transition, forKey: nil)
    }
}
