//
//  Animate.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import UIKit


// MARK: - Animate

public struct Animate {
    
    // MARK: Grouping
    
    public static func group(animations: [LayerAnimation], normalizeDurations: Bool = false, duration: NSTimeInterval? = nil, options: Options = .Default) -> LayerAnimation {
        
        let actualDuration: NSTimeInterval
        switch (normalizeDurations, duration) {
            
        case (true, let duration?) where duration != 0:
            let baseDuration = animations.reduce(0) { max($0, $1.baseDuration) }
            let factor = Float(baseDuration / duration)
            animations.forEach { $0.object.speed *= factor }
            
            actualDuration = duration
            
        case (true, _):
            actualDuration = baseDuration
            
        case (false, let duration?):
            actualDuration = duration
            
        case (false, nil):
            actualDuration = baseDuration
        }
        
        let object = CAAnimationGroup()
        object.animations = animations.map { $0.object }
        options.applyTo(object, duration: actualDuration)
        
        return LayerAnimation(object)
    }
    
    
    // MARK: Sequencing
    
    public static func sequence(animations: [LayerAnimation], normalizeDurations: Bool = false, duration: NSTimeInterval? = nil, options: Options = .Default) -> LayerAnimation {
        
        let actualDuration: NSTimeInterval
        switch (normalizeDurations, duration) {
            
        case (true, let duration?) where duration != 0:
            let baseDuration = animations.reduce(0) { $0 + $1.baseDuration }
            let factor = Float(baseDuration / duration)
            animations.forEach { $0.object.speed *= factor }
            
//            _ = animations.reduce(0 as NSTimeInterval) {
//                
//                $1.object.beginTime += $0
//                return $0 + $1.baseDuration
//            }
            actualDuration = animations.reduce(0 as NSTimeInterval) {
                
                $1.object.beginTime += $0
                return $0 + $1.baseDuration
            }
            
        case (true, _):
            actualDuration = animations.reduce(0 as NSTimeInterval) {
                
                $1.object.beginTime += $0
                return $0 + $1.baseDuration
            }
            
        case (false, let duration?):
            actualDuration = duration
            _ = animations.reduce(0 as NSTimeInterval) {
                
                $1.object.beginTime += $0
                return $0 + $1.accumulatedDuration
            }
            
        case (false, nil):
            actualDuration = animations.reduce(0 as NSTimeInterval) {
                
                $1.object.beginTime += $0
                return $0 + $1.baseDuration
            }
        }
        
        let object = CAAnimationGroup()
        object.animations = animations.map { $0.object }
        options.applyTo(object, duration: actualDuration)
        
        return LayerAnimation(object)
    }
    
    
    // MARK: Waiting
    
    public static func wait(duration: NSTimeInterval) -> LayerAnimation {
        
        let object = CABasicAnimation()
        object.duration = duration
        
        return LayerAnimation(object)
    }
    
    
    // MARK: Translating
    
    public static func moveBy(by: CGPoint, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, by: by, duration: duration, options: options)
    }
    
    public static func moveBy(x x: CGFloat, y: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, by: CGPoint(x: x, y: y), duration: duration, options: options)
    }
    
    public static func moveXBy(dx: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionX, by: dx, duration: duration, options: options)
    }
    
    public static func moveYBy(dy: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionY, by: dy, duration: duration, options: options)
    }
    
    public static func moveTo(location: CGPoint, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, to: location, duration: duration, options: options)
    }
    
    public static func moveTo(x x: CGFloat, y: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, to: CGPoint(x: x, y: y), duration: duration, options: options)
    }
    
    public static func moveXTo(x: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionX, to: x, duration: duration, options: options)
    }
    
    public static func moveYTo(y: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionY, to: y, duration: duration, options: options)
    }
    
    public static func moveAlong(path: UIBezierPath, keyTimes: [NSTimeInterval]? = nil, interpolationOptions: [Options]? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.position)
        object.path = path.CGPath
        object.keyTimes = keyTimes?.map { $0.valueForAnimationKeyframe }
        object.timingFunctions = interpolationOptions?.map { $0.timingMode.timingFunction }
        
        options.applyTo(object, duration: duration)
        
        return LayerAnimation(object)
    }
    
    
    // MARK: Rotating
    
    public static func rotateBy<T: FloatingPointKeyframeValueConvertible>(degrees degrees: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, by: degrees.degreesToRadians, duration: duration, options: options)
    }
    
    public static func rotateBy<T: FloatingPointKeyframeValueConvertible>(radians radians: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, by: radians, duration: duration, options: options)
    }
    
    public static func rotateTo<T: FloatingPointKeyframeValueConvertible>(degrees degrees: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, to: degrees.degreesToRadians, duration: duration, options: options)
    }
    
    public static func rotateTo<T: FloatingPointKeyframeValueConvertible>(radians radians: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, to: radians, duration: duration, options: options)
    }
    
    
    // MARK: Scaling
    
    public static func scaleBy(scale: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scale, by: scale, duration: duration, options: options)
    }
    
    public static func scaleBy(xScale xScale: CGFloat, yScale: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.group(
            [
                self.property(LayerKeyPath.scaleX, by: xScale, duration: duration),
                self.property(LayerKeyPath.scaleY, by: yScale, duration: duration)
            ],
            duration: duration, options: options
        )
    }
    
    public static func scaleTo(scale: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scale, to: scale, duration: duration, options: options)
    }
    
    public static func scaleTo(xScale xScale: CGFloat, yScale: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.group(
            [
                self.property(LayerKeyPath.scaleX, to: xScale, duration: duration),
                self.property(LayerKeyPath.scaleY, to: yScale, duration: duration)
            ],
            duration: duration, options: options
        )
    }
    
    public static func scaleXTo(xScale: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleX, to: xScale, duration: duration, options: options)
    }
    
    public static func scaleYTo(yScale: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleY, to: yScale, duration: duration, options: options)
    }
    
    
    // MARK: Fading
    
    public static func fadeIn(duration duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 1, duration: duration, options: options)
    }
    
    public static func fadeOut(duration duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 0, duration: duration, options: options)
    }
    
    public static func fadeAlphaTo(alpha: CGFloat, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: alpha, duration: duration, options: options)
    }
    
    
    // MARK: Custom Animations
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, from: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, from: from, duration: duration, options: options)
    }
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, by: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, by: by, duration: duration, options: options)
    }
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, to: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, to: to, duration: duration, options: options)
    }
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, from: T, by: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, from: from, by: by, duration: duration, options: options)
    }
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, by: T, to: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, by: by, to: to, duration: duration, options: options)
    }
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, from: T, to: T, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, from: from, to: to, duration: duration, options: options)
    }
    
    
    // MARK: Private
    
    private enum LayerKeyPath {
        
        static let position = "position"
        static let positionX = "position.x"
        static let positionY = "position.y"
        static let translation = "transform.translation"
        static let translationX = "transform.translation.x"
        static let translationY = "transform.translation.y"
        static let rotation = "transform.rotation"
        static let scale = "transform.scale"
        static let scaleX = "transform.scale.x"
        static let scaleY = "transform.scale.y"
        static let opacity = "opacity"
    }
    
    private static func property<T: KeyframeValueConvertible>(keyPath: String, from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        let object = CABasicAnimation(keyPath: keyPath)
        _ = from.flatMap { object.fromValue = $0.valueForAnimationKeyframe }
        _ = by.flatMap { object.byValue = $0.valueForAnimationKeyframe }
        _ = to.flatMap { object.toValue = $0.valueForAnimationKeyframe }
        
        options.applyTo(object, duration: duration)
        
        return LayerAnimation(object)
    }
}


private extension NSTimeInterval {
    
    mutating func addClamped(addend: NSTimeInterval) {
        
        guard !self.isInfinite else {
            
            return
        }
        
        if addend.isInfinite {
            
            self = addend
        }
        else {
            
            self += addend
        }
    }
    
    func sumClamped(addend: NSTimeInterval) -> NSTimeInterval {
        
        guard !self.isInfinite else {
            
            return self
        }
        
        if addend.isInfinite {
            
            return addend
        }
        else {
            
            return self + addend
        }
    }
}
