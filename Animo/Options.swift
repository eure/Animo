//
//  Options.swift
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


// MARK: - Options

public struct Options {
    
    
    // MARK: - Public
    
    public static let `default` = Options()
    
    public struct FillMode: OptionSet {
        
        public static let forwards = FillMode(rawValue: 1)
        public static let backwards = FillMode(rawValue: 2)
        public static let none: FillMode = []
        public static let both: FillMode = [.forwards, .backwards]
        
        public init(rawValue: Int) {
            
            self.rawValue = rawValue
        }
        
        public let rawValue: Int
    }
    
    public init(speed: CGFloat = 1, fillMode: FillMode = .both, removedOnCompletion: Bool = false) {
        
        func valueForCAAnimation(_ fillMode: FillMode) -> String {
            
            switch fillMode {
                
            case FillMode.forwards: return convertFromCAMediaTimingFillMode(CAMediaTimingFillMode.forwards)
            case FillMode.backwards: return convertFromCAMediaTimingFillMode(CAMediaTimingFillMode.backwards)
            case FillMode.both: return convertFromCAMediaTimingFillMode(CAMediaTimingFillMode.both)
            default: return convertFromCAMediaTimingFillMode(CAMediaTimingFillMode.removed)
            }
        }
        
        self.speed = speed
        self.fillMode = valueForCAAnimation(fillMode)
        self.removedOnCompletion = removedOnCompletion
    }
    
    
    // MARK: Internal
    
    internal let speed: CGFloat
    internal let fillMode: String
    internal let removedOnCompletion: Bool
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCAMediaTimingFillMode(_ input: CAMediaTimingFillMode) -> String {
	return input.rawValue
}
