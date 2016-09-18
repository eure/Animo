//
//  KeyframeValueConvertible.swift
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

#if os(OSX)
    import AppKit
    
#else
    import UIKit
    
#endif


// MARK: - KeyframeValueConvertible

public protocol KeyframeValueConvertible {
    
    associatedtype ValueType: AnyObject
    
    var valueForAnimationKeyframe: ValueType { get }
}


// MARK: - KeyframeValueConvertible types

extension Int8: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Int8) }
}

extension Int16: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Int16) }
}

extension Int32: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Int32) }
}

extension Int64: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Int64) }
}

extension UInt8: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as UInt8) }
}

extension UInt16: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as UInt16) }
}

extension UInt32: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as UInt32) }
}

extension UInt64: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as UInt64) }
}

extension Int: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Int) }
}

extension UInt: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as UInt) }
}

extension CGFloat: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: Double(self) as Double) }
}

extension Double: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Double) }
}

extension Float: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSNumber { return NSNumber(value: self as Float) }
}

extension CGPoint: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue {
        
        #if os(OSX)
            return NSValue(point: self)
            
        #else
            return NSValue(cgPoint: self)
            
        #endif
    }
}

extension CGSize: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue {
        
        #if os(OSX)
            return NSValue(size: self)
            
        #else
            return NSValue(cgSize: self)
            
        #endif
    }
}

extension CGRect: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue {
        
        #if os(OSX)
            return NSValue(rect: self)
            
        #else
            return NSValue(cgRect: self)
            
        #endif
    }
}

extension CGAffineTransform: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue {
        
        #if os(OSX)
            var value = self
            return NSValue(&value, withObjCType: ("{CGAffineTransform=dddddd}" as NSString).UTF8String)
            
        #else
            return NSValue(cgAffineTransform: self)
            
        #endif
    }
}

extension CGVector: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue {
        
        #if os(OSX)
            var value = self
            return NSValue(&value, withObjCType: ("{CGVector=dd}" as NSString).UTF8String)
            
        #else
            return NSValue(cgVector: self)
            
        #endif
    }
}

extension CATransform3D: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(caTransform3D: self) }
}

#if os(OSX)
    extension NSEdgeInsets: KeyframeValueConvertible {
        
        public var valueForAnimationKeyframe: NSValue { return NSValue(edgeInsets: self) }
    }
    
#else
    extension UIEdgeInsets: KeyframeValueConvertible {
        
        public var valueForAnimationKeyframe: NSValue { return NSValue(uiEdgeInsets: self) }
    }
    
    extension UIOffset: KeyframeValueConvertible {
        
        public var valueForAnimationKeyframe: NSValue { return NSValue(uiOffset: self) }
    }
    
#endif

extension NSRange: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: NSValue { return NSValue(range: self) }
}

extension NSObject: KeyframeValueConvertible {
    
    public var valueForAnimationKeyframe: AnyObject { return self }
}

#if os(OSX)
    extension NSColor /* : KeyframeValueConvertible */ {
        
        public override var valueForAnimationKeyframe: AnyObject { return self.CGColor }
    }
    
    extension NSBezierPath /* : KeyframeValueConvertible */ {
        
        public override var valueForAnimationKeyframe: AnyObject {
            
            let path = CGPathCreateMutable()
            
            var didClosePath = true
            for index in 0 ..< self.elementCount {
                
                var points = Array<CGPoint>(count: 3, repeatedValue: .zero)
                switch self.elementAtIndex(index, associatedPoints: &points) {
                    
                case .MoveToBezierPathElement:
                    CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
                    
                case .LineToBezierPathElement:
                    CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
                    didClosePath = false
                    
                case .CurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
                    didClosePath = false
                    
                case .ClosePathBezierPathElement:
                    CGPathCloseSubpath(path)
                    didClosePath = true
                }
            }
            
            if !didClosePath {
                
                CGPathCloseSubpath(path)
            }
            return path
        }
    }
    
    extension NSImage /* : KeyframeValueConvertible */ {
        
        public override var valueForAnimationKeyframe: AnyObject {
            
            return self.CGImageForProposedRect(nil, context: nil, hints: nil)!
        }
    }
    
#else
    extension UIColor /* : KeyframeValueConvertible */ {
        
        public override var valueForAnimationKeyframe: AnyObject { return self.cgColor }
    }
    
    extension UIBezierPath /* : KeyframeValueConvertible */ {
        
        public override var valueForAnimationKeyframe: AnyObject { return self.cgPath }
    }
    
    extension UIImage /* : KeyframeValueConvertible */ {
        
        public override var valueForAnimationKeyframe: AnyObject { return self.cgImage! }
    }
    
#endif


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

