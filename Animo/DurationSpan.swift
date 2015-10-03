//
//  DurationSpan.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/10/03.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import UIKit


// MARK: - DurationSpan

public enum DurationSpan: NilLiteralConvertible, FloatLiteralConvertible {
    
    // MARK: Public
    
    case Automatic
    case Constant(NSTimeInterval)
    case Infinite
    
    public static let defaultConstant = NSTimeInterval(0.3)
    
    
    // MARK: NilLiteralConvertible
    
    public init(nilLiteral: ()) {
        
        self = .Automatic
    }
    
    
    // MARK: FloatLiteralConvertible
    
    public init(floatLiteral value: NSTimeInterval) {
        
        if value == 0 {
            
            self = .Automatic
        }
        else if value.isInfinite && value > 0 {
            
            self = .Infinite
        }
        else {
            
            self = .Constant(value)
        }
    }
}
