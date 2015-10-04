//
//  Options.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Options

public struct Options {
    
    // MARK: - TimingMode
    
    public enum TimingMode {
        
        case Linear
        case EaseIn, EaseOut, EaseInOut
        case Spring(damping: CGFloat)
        
        // http://easings.net/
        case EaseInSine, EaseOutSine, EaseInOutSine
        case EaseInQuad, EaseOutQuad, EaseInOutQuad
        case EaseInCubic, EaseOutCubic, EaseInOutCubic
        case EaseInQuart, EaseOutQuart, EaseInOutQuart
        case EaseInQuint, EaseOutQuint, EaseInOutQuint
        case EaseInExpo, EaseOutExpo, EaseInOutExpo
        case EaseInCirc, EaseOutCirc, EaseInOutCirc
        case EaseInBack, EaseOutBack, EaseInOutBack
        
        case Custom(c1x: Float, c1y: Float, c2x: Float, c2y: Float)
        
        internal var timingFunction: CAMediaTimingFunction {
            
            switch self {
                
            case .Linear:       return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .EaseIn:       return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .EaseOut:      return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .EaseInOut:    return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            case .Spring(let damping):    return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + (Float(damping) / 3.0), 1, 1)
                
                // http://easings.net/
            case .EaseInSine:       return CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
            case .EaseOutSine:      return CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
            case .EaseInOutSine:    return CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)
            case .EaseInQuad:       return CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
            case .EaseOutQuad:      return CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
            case .EaseInOutQuad:    return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
            case .EaseInCubic:      return CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
            case .EaseOutCubic:     return CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
            case .EaseInOutCubic:   return CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
            case .EaseInQuart:      return CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
            case .EaseOutQuart:     return CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
            case .EaseInOutQuart:   return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
            case .EaseInQuint:      return CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
            case .EaseOutQuint:     return CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
            case .EaseInOutQuint:   return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
            case .EaseInExpo:       return CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
            case .EaseOutExpo:      return CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
            case .EaseInOutExpo:    return CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
            case .EaseInCirc:       return CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
            case .EaseOutCirc:      return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
            case .EaseInOutCirc:    return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
            case .EaseInBack:       return CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
            case .EaseOutBack:      return CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
            case .EaseInOutBack:    return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
                
            case .Custom(let c1x, let c1y, let c2x, let c2y):
                return CAMediaTimingFunction(controlPoints: c1x, c1y, c2x, c2y)
            }
        }
    }
    
    
    // MARK: - Public
    
    public static let Default = Options()
    
    public init(timingMode: TimingMode = .Linear, speed: CGFloat = 1, fillMode: String = kCAFillModeBoth, removedOnCompletion: Bool = false) {
        
        self.timingMode = timingMode
        self.speed = speed
        self.fillMode = fillMode
        self.removedOnCompletion = removedOnCompletion
    }
    
    
    // MARK: Internal
    
    internal let timingMode: TimingMode
    internal let speed: CGFloat
    internal let fillMode: String
    internal let removedOnCompletion: Bool
    
    private func applyStandardOptionsTo(object: CAAnimation) {
        
        object.timingFunction = self.timingMode.timingFunction
        object.speed = Float(self.speed)
        object.fillMode = self.fillMode
        object.removedOnCompletion = self.removedOnCompletion
    }
    
    internal func applyTo(object: CABasicAnimation, span: DurationSpan) -> LayerAnimation {
        
        self.applyStandardOptionsTo(object)
        
        switch span {
            
        case .Automatic:
            fatalError()
            
        case .Constant(let seconds):
            object.duration = seconds
            return LayerAnimation(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        case .Infinite:
            object.duration = DBL_MAX
            return LayerAnimation(
                object,
                baseDuration: 0,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal func applyTo(object: CAKeyframeAnimation, span: DurationSpan) -> LayerAnimation {
        
        self.applyStandardOptionsTo(object)
        
        switch span {
            
        case .Constant(let seconds):
            object.duration = seconds
            return LayerAnimation(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        default:
            fatalError()
        }
    }
    
    internal func applyTo(group object: CAAnimationGroup, children: [LayerAnimation], span: DurationSpan) -> LayerAnimation {
        
        self.applyStandardOptionsTo(object)
        
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
            return LayerAnimation(
                object,
                baseDuration: children.maxBaseDuration,
                accumulatedDuration: accumulatedDuration
            )
            
        case .Constant(let seconds):
            object.duration = seconds
            object.animations = children.map { $0.copyObject() }
            return LayerAnimation(object, baseDuration: seconds, accumulatedDuration: seconds)
            
        case .Infinite:
            object.duration = DBL_MAX
            object.animations = children.map { $0.copyObject() }
            return LayerAnimation(
                object,
                baseDuration: children.maxBaseDuration,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal func applyTo(sequence object: CAAnimationGroup, children: [LayerAnimation], span: DurationSpan) -> LayerAnimation {
        
        self.applyStandardOptionsTo(object)
        
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
            return LayerAnimation(
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
            return LayerAnimation(
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
            return LayerAnimation(
                object,
                baseDuration: baseDuration,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal func applyTo(repetition original: LayerAnimation, count: Int? = nil) -> LayerAnimation {
        
        let object = CAAnimationGroup()
        self.applyStandardOptionsTo(object)
        
        let copy = original.copyObject()
        object.animations = [copy]
        
        if let count = count {
            
            let frameCount = count + 1
            copy.repeatCount = Float(count)
            object.duration = copy.duration * NSTimeInterval(frameCount)
            
            return LayerAnimation(
                object,
                baseDuration: Options.multiplyDuration(original.baseDuration, by: frameCount),
                accumulatedDuration: Options.multiplyDuration(original.accumulatedDuration, by: frameCount)
            )
        }
        else {
            
            copy.repeatDuration = NSTimeInterval.infinity
            object.duration = DBL_MAX
            
            return LayerAnimation(
                object,
                baseDuration: original.baseDuration,
                accumulatedDuration: NSTimeInterval.infinity
            )
        }
    }
    
    internal func applyTo(autoreverse original: LayerAnimation) -> LayerAnimation {
        
        let object = original.copyObject()
        object.autoreverses = true
        
        return LayerAnimation(
            object,
            baseDuration: Options.multiplyDuration(original.baseDuration, by: 2),
            accumulatedDuration: Options.multiplyDuration(original.accumulatedDuration, by: 2)
        )
    }
    
    
    // MARK: Private
    
    internal static func maxDuration(lhs: NSTimeInterval, _ rhs: NSTimeInterval) -> NSTimeInterval {
        
        switch (lhs, rhs) {
            
        case (NSTimeInterval.infinity, _), (_, NSTimeInterval.infinity):
            return NSTimeInterval.infinity
            
        case (let lhs, let rhs):
            return Swift.max(lhs, rhs)
        }
    }
    
    internal static func addDuration(lhs: NSTimeInterval, _ rhs: NSTimeInterval) -> NSTimeInterval {
        
        switch (lhs, rhs) {
            
        case (NSTimeInterval.infinity, _), (_, NSTimeInterval.infinity):
            return NSTimeInterval.infinity
            
        case (let lhs, let rhs):
            return lhs + rhs
        }
    }
    
    internal static func multiplyDuration(lhs: NSTimeInterval, by rhs: Int) -> NSTimeInterval {
        
        if case NSTimeInterval.infinity = lhs {
            
            return NSTimeInterval.infinity
        }
        
        return lhs * NSTimeInterval(rhs)
    }
}


private extension SequenceType where Self.Generator.Element == LayerAnimation {
    
    var maxBaseDuration: NSTimeInterval {
        
        return self.reduce(0) { Options.maxDuration($0, $1.baseDuration) }
    }
    
    var maxAccumulatedDuration: NSTimeInterval {
        
        return self.reduce(0) { Options.maxDuration($0, $1.accumulatedDuration) }
    }
    
    var totalBaseDuration: NSTimeInterval {
        
        return self.reduce(0) { Options.addDuration($0, $1.baseDuration) }
    }
    
    var totalAccumulatedDuration: NSTimeInterval {
        
        return self.reduce(0) { Options.addDuration($0, $1.accumulatedDuration) }
    }
}