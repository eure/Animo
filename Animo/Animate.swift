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
    
    // TODO: enable in XCode 7.1/Swift 2.1
//    public static func group(animations: LayerAnimation..., span: DurationSpan = .Automatic, options: Options = .Default) -> LayerAnimation {
//        
//        return self.group(animations, span: span, options: options)
//    }
    
    public static func group(animations: [LayerAnimation], span: DurationSpan = .Automatic, options: Options = .Default) -> LayerAnimation {
        
        return options.applyTo(group: CAAnimationGroup(), children: animations, span: span)
    }
    
    
    // MARK: Sequencing
    
    // TODO: enable in XCode 7.1/Swift 2.1
//    public static func sequence(animations: LayerAnimation..., span: DurationSpan = .Automatic, options: Options = .Default) -> LayerAnimation {
//        
//        return self.sequence(animations, span: span, options: options)
//    }
    
    public static func sequence(animations: [LayerAnimation], span: DurationSpan = .Automatic, options: Options = .Default) -> LayerAnimation {
        
        return options.applyTo(sequence: CAAnimationGroup(), children: animations, span: span)
    }
    
    
    // MARK: Waiting
    
    public static func wait(duration: NSTimeInterval) -> LayerAnimation {
        
        return Options(fillMode: kCAFillModeRemoved, removedOnCompletion: true).applyTo(CABasicAnimation(), span: .Constant(duration))
    }
    
    
    // MARK: Positioning
    
    public static func move(from from: CGPoint? = nil, by: CGPoint? = nil, to: CGPoint? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.position, from: from, by: by, to: to, duration: duration, options: options)
    }
    
    public static func move(along path: UIBezierPath, keyTimes: [NSTimeInterval] = [], timingFunctions: [Options.TimingMode] = [], duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        let object = CAKeyframeAnimation(keyPath: LayerKeyPath.position)
        object.path = path.CGPath
        
        if keyTimes.count > 0 {
            
            object.keyTimes = keyTimes.map { $0.valueForAnimationKeyframe }
        }
        if timingFunctions.count > 0 {
            
            object.timingFunctions = timingFunctions.map { $0.timingFunction }
        }
        return options.applyTo(object, span: .Constant(duration))
    }
    
    public static func moveX(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionX, from: from, by: by, to: to, duration: duration, options: options)
    }
    
    public static func moveY(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.positionY, from: from, by: by, to: to, duration: duration, options: options)
    }
    
    
    // MARK: Rotating
    
    public static func rotateDegrees<T: FloatingPointKeyframeValueConvertible>(from from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, from: from?.degreesToRadians, by: by?.degreesToRadians, to: to?.degreesToRadians, duration: duration, options: options)
    }
    
    public static func rotateRadians<T: FloatingPointKeyframeValueConvertible>(from from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.rotation, from: from, by: by, to: to, duration: duration, options: options)
    }
    
    
    // MARK: Scaling
    
    public static func scale(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.scale, from: from, by: by, to: to, duration: duration, options: options)
    }
    
    public static func scale(from from: CGSize? = nil, by: CGSize? = nil, to: CGSize? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.group(
            [
                self.property(LayerKeyPath.scaleX, from: from?.width, by: by?.width, to: to?.width, duration: duration),
                self.property(LayerKeyPath.scaleY, from: from?.height, by: by?.height, to: to?.height, duration: duration)
            ],
            span: .Constant(duration),
            options: options
        )
    }
    
    
    // MARK: Fading
    
    public static func fadeIn(duration duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 1, duration: duration, options: options)
    }
    
    public static func fadeOut(duration duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, to: 0, duration: duration, options: options)
    }
    
    public static func fade(from from: CGFloat? = nil, by: CGFloat? = nil, to: CGFloat? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(LayerKeyPath.opacity, from: from, by: by, to: to, duration: duration, options: options)
    }
    
    
    // MARK: Custom Animations
    
    public static func keyPath<T: KeyframeValueConvertible>(keyPath: String, from: T? = nil, by: T? = nil, to: T? = nil, duration: NSTimeInterval, options: Options = .Default) -> LayerAnimation {
        
        return self.property(keyPath, from: from, by: by, to: to, duration: duration, options: options)
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


