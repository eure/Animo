//
//  CALayer+Animo.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright (c) 2015 eureka, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
    
    public func runTransition(type: Transition = .Fade, duration: NSTimeInterval = 0, timingMode: TimingMode = .Linear, options: Options = Options(fillMode: [], removedOnCompletion: true)) {
        
        let transition = CATransition()
        type.applyTo(transition)
        transition.duration = duration
        transition.applyOptions(options)
        
        self.addAnimation(transition, forKey: nil)
    }
}


// MARK: - LayerAnimation

public extension LayerAnimation {
    
    public func runOnLayer(layer: CALayer, withKey key: String = NSUUID().UUIDString) -> String {
        
        return layer.runAnimation(self, forKey: key)
    }
}
