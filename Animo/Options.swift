//
//  Options.swift
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

import Foundation
import UIKit


// MARK: - Options

public struct Options {
    
    // MARK: - Public
    
    public struct FillMode: OptionSetType {
        
        public static let Forwards = FillMode(rawValue: 1)
        public static let Backwards = FillMode(rawValue: 2)
        public static let None: FillMode = []
        public static let Both: FillMode = [.Forwards, .Backwards]
        
        public init(rawValue: Int) {
            
            self.rawValue = rawValue
        }
        
        public let rawValue: Int
        
        private var valueForOptions: String {
            
            switch self {
                
            case FillMode.Forwards: return kCAFillModeForwards
            case FillMode.Backwards: return kCAFillModeBackwards
            case FillMode.Both: return kCAFillModeBoth
            default: return kCAFillModeRemoved
            }
        }
    }
    
    public static let Default = Options()
    
    public init(speed: CGFloat = 1, fillMode: FillMode = .Both, removedOnCompletion: Bool = false) {
        
        self.speed = speed
        self.fillMode = fillMode.valueForOptions
        self.removedOnCompletion = removedOnCompletion
    }
    
    
    // MARK: Internal
    
    internal let speed: CGFloat
    internal let fillMode: String
    internal let removedOnCompletion: Bool
}
