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