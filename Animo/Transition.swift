//
//  Transition.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/10/08.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import UIKit


// MARK: - Transition

public enum Transition {
    
    // MARK: - Directions
    
    public enum Direction {
        
        case LeftToRight
        case RightToLeft
        case TopToBottom
        case BottomToTop
        
        private var valueForCATransition: String {
            
            switch self {
                
            case .LeftToRight:  return kCATransitionFromLeft
            case .RightToLeft:  return kCATransitionFromRight
            case .TopToBottom:  return kCATransitionFromTop
            case .BottomToTop:  return kCATransitionFromBottom
            }
        }
    }
    
    
    // MARK: Public
    
    case Fade
    case MoveIn(Direction)
    case Push(Direction)
    case Reveal(Direction)
    
    
    // MARK: Internal
    
    internal func applyTo(object: CATransition) {
        
        switch self {
            
        case .Fade:
            object.type = kCATransitionFade
            object.subtype = nil
            
        case .MoveIn(let direction):
            object.type = kCATransitionMoveIn
            object.subtype = direction.valueForCATransition
            
        case .Push(let direction):
            object.type = kCATransitionPush
            object.subtype = direction.valueForCATransition
            
        case .Reveal(let direction):
            object.type = kCATransitionReveal
            object.subtype = direction.valueForCATransition
        }
    }
}
