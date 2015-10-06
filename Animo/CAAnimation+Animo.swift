//
//  CAAnimation+Animo.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/10/05.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import QuartzCore


// MARK: - CAAnimation

internal extension CAAnimation {
    
    // MARK: Internal
    
    internal func applyOptions(options: Options = .Default) {
        
        self.speed = Float(options.speed)
        self.fillMode = options.fillMode
        self.removedOnCompletion = options.removedOnCompletion
    }
}