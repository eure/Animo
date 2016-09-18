//
//  Animo.swift
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

import QuartzCore

#if os(OSX)
    import AppKit
    
#else
    import UIKit
    
#endif


// MARK: - Animo

public enum Animo {
    
    
    // MARK: Grouping
    
    public static func group(_ animations: LayerAnimation..., span: DurationSpan = .automatic, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.group(animations, span: span, timingMode: timingMode, options: options)
    }
    
    public static func group<S: Sequence>(_ animations: S, span: DurationSpan = .automatic, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation where S.Iterator.Element == LayerAnimation {
        
        return LayerAnimation(group: CAAnimationGroup(), children: animations, span: span, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Sequencing
    
    public static func sequence(_ animations: LayerAnimation..., span: DurationSpan = .automatic, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.sequence(animations, span: span, timingMode: timingMode, options: options)
    }
    
    public static func sequence<S: Sequence>(_ animations: S, span: DurationSpan = .automatic, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation where S.Iterator.Element == LayerAnimation {
        
        return LayerAnimation(sequence: CAAnimationGroup(), children: animations, span: span, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Waiting
    
    public static func wait(_ duration: TimeInterval) -> LayerAnimation {
        
        return LayerAnimation(object: CABasicAnimation(), span: .constant(duration), timingMode: .linear, options: Options(fillMode: [], removedOnCompletion: true))
    }
    
    
    // MARK: Repeating
    
    public static func replay(_ animation: LayerAnimation, count: Int) -> LayerAnimation {
        
        return LayerAnimation(repetition: animation, count: count)
    }
    
    public static func replayForever(_ animation: LayerAnimation) -> LayerAnimation {
        
        return LayerAnimation(repetition: animation)
    }
    
    
    // MARK: Reversing
    
    public static func autoreverse(_ animation: LayerAnimation) -> LayerAnimation {
        
        return LayerAnimation(autoreverse: animation)
    }
    
    
    // MARK: Positioning
    
    public static func move(from: CGPoint? = nil, by: CGPoint? = nil, to: CGPoint? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    #if os(OSX)
    public static func move(along path: NSBezierPath, keyTimes: [TimeInterval] = [], timingFunctions: [TimingMode] = [], duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.position)
        object.path = (path.valueForAnimationKeyframe as! CGPath)
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return LayerAnimation(object: object, span: .constant(duration), timingMode: timingMode, options: options)
    }
    
    #else
    public static func move(along path: UIBezierPath, keyTimes: [TimeInterval] = [], timingFunctions: [TimingMode] = [], duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.position)
        object.path = path.cgPath
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return LayerAnimation(object: object, span: .constant(duration), timingMode: timingMode, options: options)
    }
    
    #endif
    
    public static func moveX(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionX, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func moveY(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionY, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Translating
    
    public static func translate(from: CGPoint? = nil, by: CGPoint? = nil, to: CGPoint? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.translation, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    #if os(OSX)
    public static func translate(along path: NSBezierPath, keyTimes: [TimeInterval] = [], timingFunctions: [TimingMode] = [], duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.translation)
        object.path = (path.valueForAnimationKeyframe as! CGPath)
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return LayerAnimation(object: object, span: .constant(duration), timingMode: timingMode, options: options)
    }
    
    #else
    public static func translate(along path: UIBezierPath, keyTimes: [TimeInterval] = [], timingFunctions: [TimingMode] = [], duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.translation)
        object.path = path.cgPath
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return LayerAnimation(object: object, span: .constant(duration), timingMode: timingMode, options: options)
    }
    
    #endif
    
    public static func translateX(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.translationX, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func translateY(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.translationY, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Rotating
    
    public static func rotateDegrees<T: FloatingPointKeyframeValueConvertible>(from: T? = nil, by: T? = nil, to: T? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, from: from?.degreesToRadians, by: by?.degreesToRadians, to: to?.degreesToRadians, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func rotateRadians<T: FloatingPointKeyframeValueConvertible>(from: T? = nil, by: T? = nil, to: T? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Scaling
    
    public static func scale(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scale, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func scale(from: CGSize? = nil, by: CGSize? = nil, to: CGSize? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.group(
            self.property(LayerKeyPath.scaleX, from: from?.width, by: by?.width, to: to?.width, duration: duration, timingMode: timingMode, options: .default),
            self.property(LayerKeyPath.scaleY, from: from?.height, by: by?.height, to: to?.height, duration: duration, timingMode: timingMode, options: .default),
            span: .constant(duration),
            options: options
        )
    }
    
    public static func scaleX(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleX, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func scaleY(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleY, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func scaleZ(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleZ, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Fading
    
    public static func fadeIn(duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 1, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func fadeOut(duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 0, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func fade(from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Custom Animations
    
    public static func keyPath<T: KeyframeValueConvertible>(_ keyPath: String, from: T? = nil, by: T? = nil, to: T? = nil, duration: TimeInterval, timingMode: TimingMode = .linear, options: Options = .default) -> LayerAnimation {
        
        return self.property(keyPath, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Private
    
    fileprivate enum LayerKeyPath {
        
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
        static let scaleZ = "transform.scale.z"
        static let opacity = "opacity"
    }
    
    fileprivate static func property<T: KeyframeValueConvertible>(_ keyPath: String, from: T? = nil, by: T? = nil, to: T? = nil, duration: TimeInterval, timingMode: TimingMode, options: Options) -> LayerAnimation {
        
        let object = CABasicAnimation(keyPath: keyPath)
        _ = from.flatMap { object.fromValue = $0.valueForAnimationKeyframe }
        _ = by.flatMap { object.byValue = $0.valueForAnimationKeyframe }
        _ = to.flatMap { object.toValue = $0.valueForAnimationKeyframe }
        
        return LayerAnimation(object: object, span: .constant(duration), timingMode: timingMode, options: options)
    }
}


