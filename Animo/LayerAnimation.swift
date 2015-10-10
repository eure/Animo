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
    
    public let accumulatedDuration: NSTimeInterval
    public let baseDuration: NSTimeInterval
    
    
    // MARK: Internal
    
    internal init(object: CABasicAnimation, span: DurationSpan, timingMode: TimingMode, options: Options) {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .Automatic:
            fatalError()
            
        case .Constant(let seconds):
            object.duration = seconds
            self.init(
                object,
                baseDuration: seconds,
                accumulatedDuration: seconds
            )
            
        case .Infinite:
            object.duration = DBL_MAX
            self.init(
                object,
                baseDuration: 0,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal init(object: CAKeyframeAnimation, span: DurationSpan, timingMode: TimingMode, options: Options) {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .Constant(let seconds):
            object.duration = seconds
            self.init(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        default:
            fatalError()
        }
    }
    
    internal init<S: SequenceType where S.Generator.Element == LayerAnimation>(group object: CAAnimationGroup, children: S, span: DurationSpan, timingMode: TimingMode, options: Options) {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .Automatic:
            let accumulatedDuration = children.maxAccumulatedDuration
            if case NSTimeInterval.infinity = accumulatedDuration {
                
                object.duration = DBL_MAX
            }
            else {
                
                object.duration = accumulatedDuration
            }
            object.animations = children.map { $0.copyObject() }
            self.init(
                object,
                baseDuration: children.maxBaseDuration,
                accumulatedDuration: accumulatedDuration
            )
            
        case .Constant(let seconds):
            object.duration = seconds
            object.animations = children.map { $0.copyObject() }
            self.init(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        case .Infinite:
            object.duration = DBL_MAX
            object.animations = children.map { $0.copyObject() }
            self.init(
                object,
                baseDuration: children.maxBaseDuration,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal init<S: SequenceType where S.Generator.Element == LayerAnimation>(sequence object: CAAnimationGroup, children: S, span: DurationSpan, timingMode: TimingMode, options: Options) {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .Automatic:
            let accumulatedDuration = children.totalAccumulatedDuration
            if case NSTimeInterval.infinity = accumulatedDuration {
                
                object.duration = DBL_MAX
            }
            else {
                
                object.duration = accumulatedDuration
            }
            var baseDuration = NSTimeInterval(0)
            object.animations = children.map {
                
                let object = $0.copyObject()
                object.beginTime = baseDuration
                baseDuration += $0.baseDuration
                return object
            }
            self.init(
                object,
                baseDuration: baseDuration,
                accumulatedDuration: accumulatedDuration
            )
            
        case .Constant(let seconds):
            object.duration = seconds
            var baseDuration = NSTimeInterval(0)
            object.animations = children.map {
                
                let object = $0.copyObject()
                object.beginTime = baseDuration
                baseDuration += $0.baseDuration
                return object
            }
            self.init(
                object,
                baseDuration: baseDuration,
                accumulatedDuration: seconds
            )
            
        case .Infinite:
            object.duration = DBL_MAX
            var baseDuration = NSTimeInterval(0)
            object.animations = children.map {
                
                let object = $0.copyObject()
                object.beginTime = baseDuration
                baseDuration += $0.baseDuration
                return object
            }
            self.init(
                object,
                baseDuration: baseDuration,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal init(repetition original: LayerAnimation, count: Int? = nil) {
        
        let object = CAAnimationGroup()
        object.applyOptions()
        
        let copy = original.copyObject()
        object.animations = [copy]
        
        if let count = count {
            
            let frameCount = count + 1
            copy.repeatCount = Float(count)
            object.duration = copy.duration * NSTimeInterval(frameCount)
            
            self.init(
                object,
                baseDuration: multiplyDuration(original.baseDuration, by: frameCount),
                accumulatedDuration: multiplyDuration(original.accumulatedDuration, by: frameCount)
            )
        }
        else {
            
            copy.repeatDuration = NSTimeInterval.infinity
            object.duration = DBL_MAX
            
            self.init(
                object,
                baseDuration: original.baseDuration,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal init(autoreverse original: LayerAnimation) {
        
        let object = original.copyObject()
        object.autoreverses = true
        
        self.init(
            object,
            baseDuration: multiplyDuration(original.baseDuration, by: 2),
            accumulatedDuration: multiplyDuration(original.accumulatedDuration, by: 2)
        )
    }
    
    internal init(transition object: CATransition, duration: NSTimeInterval, timingMode: TimingMode, options: Options) {
        
        object.applyOptions()
        
        self.init(
            object,
            baseDuration: duration,
            accumulatedDuration: duration
        )
    }
    
    internal init(_ object: CAAnimation, baseDuration: NSTimeInterval, accumulatedDuration: NSTimeInterval) {
        
        self.object = object
        self.baseDuration = baseDuration
        self.accumulatedDuration = accumulatedDuration
    }
    
    internal func copyObject() -> CAAnimation {
        
        let original = self.object
        
        let copy = original.copy() as! CAAnimation
        copy.delegate = original.delegate
        
        return copy
    }
    
    
    // MARK: Private
    
    private let object: CAAnimation
}


// MARK: Private

private func maxDuration(lhs: NSTimeInterval, _ rhs: NSTimeInterval) -> NSTimeInterval {
    
    switch (lhs, rhs) {
        
    case (NSTimeInterval.infinity, _), (_, NSTimeInterval.infinity):
        return NSTimeInterval.infinity
        
    case (let lhs, let rhs):
        return Swift.max(lhs, rhs)
    }
}

private func addDuration(lhs: NSTimeInterval, _ rhs: NSTimeInterval) -> NSTimeInterval {
    
    switch (lhs, rhs) {
        
    case (NSTimeInterval.infinity, _), (_, NSTimeInterval.infinity):
        return NSTimeInterval.infinity
        
    case (let lhs, let rhs):
        return lhs + rhs
    }
}

private func multiplyDuration(lhs: NSTimeInterval, by rhs: Int) -> NSTimeInterval {
    
    if case NSTimeInterval.infinity = lhs {
        
        return NSTimeInterval.infinity
    }
    
    return lhs * NSTimeInterval(rhs)
}


private extension SequenceType where Self.Generator.Element == LayerAnimation {
    
    var maxBaseDuration: NSTimeInterval {
        
        return self.reduce(0) { maxDuration($0, $1.baseDuration) }
    }
    
    var maxAccumulatedDuration: NSTimeInterval {
        
        return self.reduce(0) { maxDuration($0, $1.accumulatedDuration) }
    }
    
    var totalBaseDuration: NSTimeInterval {
        
        return self.reduce(0) { addDuration($0, $1.baseDuration) }
    }
    
    var totalAccumulatedDuration: NSTimeInterval {
        
        return self.reduce(0) { addDuration($0, $1.accumulatedDuration) }
    }
}
