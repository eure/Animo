//
//  KeyframeValueConvertible.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import UIKit


// MARK: - KeyframeValueConvertible

public protocol KeyframeValueConvertible {
    
    typealias ValueType: AnyObject
    
    var valueForAnimationKeyframe: ValueType { get }
}


// MARK: - KeyframeValueConvertible types

extension Int8: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(char: self) }
}

extension Int16: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(short: self) }
}

extension Int32: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(int: self) }
}

extension Int64: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(longLong: self) }
}

extension UInt8: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(unsignedChar: self) }
}

extension UInt16: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(unsignedShort: self) }
}

extension UInt32: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(unsignedInt: self) }
}

extension UInt64: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(unsignedLongLong: self) }
}

extension Int: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(integer: self) }
}

extension UInt: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(unsignedLong: self) }
}

extension CGFloat: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(double: Double(self)) }
}

extension Double: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(double: self) }
}

extension Float: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(float: self) }
}

extension CGPoint: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(CGPoint: self) }
}

extension CGSize: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(CGSize: self) }
}

extension CGRect: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(CGRect: self) }
}

extension CGAffineTransform: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(CGAffineTransform: self) }
}

extension CGVector: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(CGVector: self) }
}

extension CATransform3D: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(CATransform3D: self) }
}

extension UIEdgeInsets: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(UIEdgeInsets: self) }
}

extension UIOffset: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(UIOffset: self) }
}

extension NSRange: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(range: self) }
}

extension UIColor /* : KeyframeValueConvertible */ {
    
    public override var valueForAnimationKeyframe: AnyObject { return self.CGColor }
}

extension UIBezierPath /* : KeyframeValueConvertible */ {
    
    public override var valueForAnimationKeyframe: AnyObject { return self.CGPath }
}

extension UIImage /* : KeyframeValueConvertible */ {
    
    public override var valueForAnimationKeyframe: AnyObject { return self.CGImage! }
}

extension NSObject: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: AnyObject { return self }
}


// MARK: FloatingPointKeyframeValueConvertible

public protocol FloatingPointKeyframeValueConvertible: KeyframeValueConvertible {

    var degreesToRadians: Self { get }
}

extension CGFloat: FloatingPointKeyframeValueConvertible {

    public var degreesToRadians: CGFloat {
        
        return CGFloat(M_PI * Double(self) / 180.0)
    }
}

extension Double: FloatingPointKeyframeValueConvertible {
    
    public var degreesToRadians: Double {
        
        return M_PI * self / 180.0
    }
}

extension Float: FloatingPointKeyframeValueConvertible {
    
    public var degreesToRadians: Float {
        
        return Float(M_PI * Double(self) / 180.0)
    }
}

