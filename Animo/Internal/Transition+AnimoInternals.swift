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
    
    internal func applyTo(_ object: CATransition) {
        
        func subtypeForCATransition(_ direction: Direction) -> String {
            
            switch direction {
                
            case .leftToRight:  return convertFromCATransitionSubtype(CATransitionSubtype.fromLeft)
            case .rightToLeft:  return convertFromCATransitionSubtype(CATransitionSubtype.fromRight)
            case .topToBottom:  return convertFromCATransitionSubtype(CATransitionSubtype.fromTop)
            case .bottomToTop:  return convertFromCATransitionSubtype(CATransitionSubtype.fromBottom)
            }
        }
        
        switch self {
            
        case .fade:
            object.type = CATransitionType.fade
            object.subtype = nil
            
        case .moveIn(let direction):
            object.type = CATransitionType.moveIn
            object.subtype = convertToOptionalCATransitionSubtype(subtypeForCATransition(direction))
            
        case .push(let direction):
            object.type = CATransitionType.push
            object.subtype = convertToOptionalCATransitionSubtype(subtypeForCATransition(direction))
            
        case .reveal(let direction):
            object.type = CATransitionType.reveal
            object.subtype = convertToOptionalCATransitionSubtype(subtypeForCATransition(direction))
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionSubtype(_ input: CATransitionSubtype) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
	guard let input = input else { return nil }
	return CATransitionSubtype(rawValue: input)
}
