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
    
    public static func group(animations: [LayerAnimation], span: DurationSpan = .Automatic, options: Options = .Default) -> LayerAnimation {
        
        return options.applyTo(group: CAAnimationGroup(), children: animations, span: span)
    }
    
    
    // MARK: Sequencing
    
    public static func sequence(animations: [LayerAnimation], span: DurationSpan = .Automatic, options: Options = .Default) -> LayerAnimation {
        
        return options.applyTo(sequence: CAAnimationGroup(), children: animations, span: span)
    }
    
    
    // MARK: Waiting
    
    public static func wait(duration: NSTimeInterval) -> LayerAnimation {
        
        return Options().applyTo(CABasicAnimation(), span: .Constant(duration))
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
    
    public static func moveAlong(path: UIBezierPath, keyTimes: [NSTimeInterval]? = nil, timingFunctions: [Options.TimingMode]? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.position)
        object.path = path.CGPath
        object.keyTimes = keyTimes?.map { $0.valueForAnimationKeyframe }
        object.timingFunctions = timingFunctions?.map { $0.timingFunction }
        
        return options.applyTo(object, span: .Constant(duration))
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
            span: .Constant(duration),
            options: options
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
            span: .Constant(duration),
            options: options
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
        
        return options.applyTo(object, span: .Constant(duration))
    }
}
