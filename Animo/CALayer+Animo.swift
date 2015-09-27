//
//  CALayer+Animo.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CALayer

public extension CALayer {
    
    public func runAnimation(animation: LayerAnimation, forKey key: String = NSUUID().UUIDString) -> String {
        
        self.addAnimation(animation.object, forKey: key)
        return key
    }
}
