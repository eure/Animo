//
//  Transition+AnimoInternals.swift
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

import Foundation
import QuartzCore


// MARK: - Transition

internal extension Transition {
    
    
    // MARK: Internal
    
    internal func applyTo(object: CATransition) {
        
        func subtypeForCATransition(direction: Direction) -> String {
            
            switch direction {
                
            case .LeftToRight:  return kCATransitionFromLeft
            case .RightToLeft:  return kCATransitionFromRight
            case .TopToBottom:  return kCATransitionFromTop
            case .BottomToTop:  return kCATransitionFromBottom
            }
        }
        
        switch self {
            
        case .Fade:
            object.type = kCATransitionFade
            object.subtype = nil
            
        case .MoveIn(let direction):
            object.type = kCATransitionMoveIn
            object.subtype = subtypeForCATransition(direction)
            
        case .Push(let direction):
            object.type = kCATransitionPush
            object.subtype = subtypeForCATransition(direction)
            
        case .Reveal(let direction):
            object.type = kCATransitionReveal
            object.subtype = subtypeForCATransition(direction)
        }
    }
}
