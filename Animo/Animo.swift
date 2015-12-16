//
//  Animo.swift
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

import UIKit


// MARK: - Animo

public enum Animo {
    
    // MARK: Grouping
    
    public static func group(animations: LayerAnimation..., span: DurationSpan = .Automatic, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.group(animations, span: span, timingMode: timingMode, options: options)
    }
    
    public static func group<S: SequenceType where S.Generator.Element == LayerAnimation>(animations: S, span: DurationSpan = .Automatic, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return LayerAnimation(group: CAAnimationGroup(), children: animations, span: span, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Sequencing
    
    public static func sequence(animations: LayerAnimation..., span: DurationSpan = .Automatic, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.sequence(animations, span: span, timingMode: timingMode, options: options)
    }
    
    public static func sequence<S: SequenceType where S.Generator.Element == LayerAnimation>(animations: S, span: DurationSpan = .Automatic, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return LayerAnimation(sequence: CAAnimationGroup(), children: animations, span: span, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Waiting
    
    public static func wait(duration: NSTimeInterval) -> LayerAnimation {
        
        return LayerAnimation(object: CABasicAnimation(), span: .Constant(duration), timingMode: .Linear, options: Options(fillMode: [], removedOnCompletion: true))
    }
    
    
    // MARK: Repeating
    
    public static func replay(animation: LayerAnimation, count: Int) -> LayerAnimation {
        
        return LayerAnimation(repetition: animation, count: count)
    }
    
    public static func replayForever(animation: LayerAnimation) -> LayerAnimation {
        
        return LayerAnimation(repetition: animation)
    }
    
    
    // MARK: Reversing
    
    public static func autoreverse(animation: LayerAnimation) -> LayerAnimation {
        
        return LayerAnimation(autoreverse: animation)
    }
    
    
    // MARK: Positioning
    
    public static func move(from from: CGPoint? = nil, by: CGPoint? = nil, to: CGPoint? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func move(along path: UIBezierPath, keyTimes: [NSTimeInterval] = [], timingFunctions: [TimingMode] = [], duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.position)
        object.path = path.CGPath
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return LayerAnimation(object: object, span: .Constant(duration), timingMode: timingMode, options: options)
    }
    
    public static func moveX(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionX, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func moveY(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionY, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Translating
    
    public static func translate(from from: CGPoint? = nil, by: CGPoint? = nil, to: CGPoint? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.translation, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func translate(along path: UIBezierPath, keyTimes: [NSTimeInterval] = [], timingFunctions: [TimingMode] = [], duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.translation)
        object.path = path.CGPath
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return LayerAnimation(object: object, span: .Constant(duration), timingMode: timingMode, options: options)
    }
    
    public static func translateX(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.translationX, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func translateY(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.translationY, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Rotating
    
    public static func rotateDegrees<T: FloatingPointKeyframeValueConvertible>(from from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, from: from?.degreesToRadians, by: by?.degreesToRadians, to: to?.degreesToRadians, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func rotateRadians<T: FloatingPointKeyframeValueConvertible>(from from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Scaling
    
    public static func scale(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scale, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func scale(from from: CGSize? = nil, by: CGSize? = nil, to: CGSize? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.group(
            self.property(LayerKeyPath.scaleX, from: from?.width, by: by?.width, to: to?.width, duration: duration, timingMode: timingMode, options: .Default),
            self.property(LayerKeyPath.scaleY, from: from?.height, by: by?.height, to: to?.height, duration: duration, timingMode: timingMode, options: .Default),
            span: .Constant(duration),
            options: options
        )
    }
    
    public static func scaleX(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleX, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func scaleY(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleY, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func scaleZ(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scaleZ, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Fading
    
    public static func fadeIn(duration duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 1, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func fadeOut(duration duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 0, duration: duration, timingMode: timingMode, options: options)
    }
    
    public static func fade(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
    }
    
    
    // MARK: Custom Animations
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, timingMode: TimingMode = .Linear, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, from: from, by: by, to: to, duration: duration, timingMode: timingMode, options: options)
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
        static let scaleZ = "transform.scale.z"
        static let opacity = "opacity"
    }
    
    private static func property<T: KeyframeValueConvertible>(keyPath: String, from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, timingMode: TimingMode, options: Options) -> LayerAnimation {
        
        let object = CABasicAnimation(keyPath: keyPath)
        _ = from.flatMap { object.fromValue = $0.valueForAnimationKeyframe }
        _ = by.flatMap { object.byValue = $0.valueForAnimationKeyframe }
        _ = to.flatMap { object.toValue = $0.valueForAnimationKeyframe }
        
        return LayerAnimation(object: object, span: .Constant(duration), timingMode: timingMode, options: options)
    }
}


