//
//  LayerAnimation.swift
//  Animo
//
//  Copyright © 2016 eureka, Inc.
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
import QuartzCore


// MARK: - LayerAnimation

public struct LayerAnimation {
    
    
    // MARK: Public
    
    public let accumulatedDuration: TimeInterval
    public let baseDuration: TimeInterval
    
    public func runOnLayer(_ layer: CALayer, withKey key: String = UUID().uuidString) -> String {
        
        return layer.runAnimation(self, forKey: key)
    }
    
    
    // MARK: Internal
    
    internal init(object: CABasicAnimation, span: DurationSpan, timingMode: TimingMode, options: Options) {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .automatic:
            fatalError()
            
        case .constant(let seconds):
            object.duration = seconds
            self.init(
                object,
                baseDuration: seconds,
                accumulatedDuration: seconds
            )
            
        case .infinite:
            object.duration = .greatestFiniteMagnitude
            self.init(
                object,
                baseDuration: 0,
                accumulatedDuration: TimeInterval.infinity
            )
        }
    }
    
    internal init(object: CAKeyframeAnimation, span: DurationSpan, timingMode: TimingMode, options: Options) {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .constant(let seconds):
            object.duration = seconds
            self.init(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        default:
            fatalError()
        }
    }
    
    internal init<S: Sequence>(group object: CAAnimationGroup, children: S, span: DurationSpan, timingMode: TimingMode, options: Options) where S.Iterator.Element == LayerAnimation {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .automatic:
            let accumulatedDuration = children.maxAccumulatedDuration
            if case TimeInterval.infinity = accumulatedDuration {
                
                object.duration = .greatestFiniteMagnitude
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
            
        case .constant(let seconds):
            object.duration = seconds
            object.animations = children.map { $0.copyObject() }
            self.init(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        case .infinite:
            object.duration = .greatestFiniteMagnitude
            object.animations = children.map { $0.copyObject() }
            self.init(
                object,
                baseDuration: children.maxBaseDuration,
                accumulatedDuration: TimeInterval.infinity
            )
        }
    }
    
    internal init<S: Sequence>(sequence object: CAAnimationGroup, children: S, span: DurationSpan, timingMode: TimingMode, options: Options) where S.Iterator.Element == LayerAnimation {
        
        object.timingFunction = timingMode.timingFunction
        object.applyOptions(options)
        
        switch span {
            
        case .automatic:
            let accumulatedDuration = children.totalAccumulatedDuration
            if case TimeInterval.infinity = accumulatedDuration {
                
                object.duration = .greatestFiniteMagnitude
            }
            else {
                
                object.duration = accumulatedDuration
            }
            var baseDuration = TimeInterval(0)
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
            
        case .constant(let seconds):
            object.duration = seconds
            var baseDuration = TimeInterval(0)
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
            
        case .infinite:
            object.duration = .greatestFiniteMagnitude
            var baseDuration = TimeInterval(0)
            object.animations = children.map {
                
                let object = $0.copyObject()
                object.beginTime = baseDuration
                baseDuration += $0.baseDuration
                return object
            }
            self.init(
                object,
                baseDuration: baseDuration,
                accumulatedDuration: TimeInterval.infinity
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
            object.duration = copy.duration * TimeInterval(frameCount)
            
            self.init(
                object,
                baseDuration: multiplyDuration(original.baseDuration, by: frameCount),
                accumulatedDuration: multiplyDuration(original.accumulatedDuration, by: frameCount)
            )
        }
        else {
            
            copy.repeatDuration = TimeInterval.infinity
            object.duration = .greatestFiniteMagnitude
            
            self.init(
                object,
                baseDuration: original.baseDuration,
                accumulatedDuration: TimeInterval.infinity
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
    
    internal init(transition object: CATransition, duration: TimeInterval, timingMode: TimingMode, options: Options) {
        
        object.applyOptions()
        
        self.init(
            object,
            baseDuration: duration,
            accumulatedDuration: duration
        )
    }
    
    internal init(_ object: CAAnimation, baseDuration: TimeInterval, accumulatedDuration: TimeInterval) {
        
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
    
    fileprivate let object: CAAnimation
}


// MARK: Private

private func maxDuration(_ lhs: TimeInterval, _ rhs: TimeInterval) -> TimeInterval {
    
    switch (lhs, rhs) {
        
    case (TimeInterval.infinity, _), (_, TimeInterval.infinity):
        return TimeInterval.infinity
        
    case (let lhs, let rhs):
        return Swift.max(lhs, rhs)
    }
}

private func addDuration(_ lhs: TimeInterval, _ rhs: TimeInterval) -> TimeInterval {
    
    switch (lhs, rhs) {
        
    case (TimeInterval.infinity, _), (_, TimeInterval.infinity):
        return TimeInterval.infinity
        
    case (let lhs, let rhs):
        return lhs + rhs
    }
}

private func multiplyDuration(_ lhs: TimeInterval, by rhs: Int) -> TimeInterval {
    
    if case TimeInterval.infinity = lhs {
        
        return TimeInterval.infinity
    }
    
    return lhs * TimeInterval(rhs)
}


private extension Sequence where Self.Iterator.Element == LayerAnimation {
    
    var maxBaseDuration: TimeInterval {
        
        return self.reduce(0) { maxDuration($0, $1.baseDuration) }
    }
    
    var maxAccumulatedDuration: TimeInterval {
        
        return self.reduce(0) { maxDuration($0, $1.accumulatedDuration) }
    }
    
    var totalBaseDuration: TimeInterval {
        
        return self.reduce(0) { addDuration($0, $1.baseDuration) }
    }
    
    var totalAccumulatedDuration: TimeInterval {
        
        return self.reduce(0) { addDuration($0, $1.accumulatedDuration) }
    }
}
