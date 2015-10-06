//
//  Options.swift
//  Animo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Options

public struct Options {
    
    // MARK: - Public
    
    public static let Default = Options()
    
    public init(speed: CGFloat = 1, fillMode: String = kCAFillModeBoth, removedOnCompletion: Bool = false) {
        
        self.speed = speed
        self.fillMode = fillMode
        self.removedOnCompletion = removedOnCompletion
    }
    
    
    // MARK: Internal
    
    internal let speed: CGFloat
    internal let fillMode: String
    internal let removedOnCompletion: Bool
    
}