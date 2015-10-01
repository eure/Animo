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
    
    // MARK: - TimingMode
    
    public enum TimingMode {
        
        case Linear
        case EaseIn, EaseOut, EaseInOut
        case Spring(damping: CGFloat)
        
        // http://easings.net/
        case EaseInSine, EaseOutSine, EaseInOutSine
        case EaseInQuad, EaseOutQuad, EaseInOutQuad
        case EaseInCubic, EaseOutCubic, EaseInOutCubic
        case EaseInQuart, EaseOutQuart, EaseInOutQuart
        case EaseInQuint, EaseOutQuint, EaseInOutQuint
        case EaseInExpo, EaseOutExpo, EaseInOutExpo
        case EaseInCirc, EaseOutCirc, EaseInOutCirc
        case EaseInBack, EaseOutBack, EaseInOutBack
        
        case Custom(c1x: Float, c1y: Float, c2x: Float, c2y: Float)
        
        internal var timingFunction: CAMediaTimingFunction {
            
            switch self {
                
            case .Linear:       return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .EaseIn:       return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .EaseOut:      return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .EaseInOut:    return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            case .Spring(let damping):    return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + (Float(damping) / 3.0), 1, 1)
                
                // http://easings.net/
            case .EaseInSine:       return CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
            case .EaseOutSine:      return CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
            case .EaseInOutSine:    return CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)
            case .EaseInQuad:       return CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
            case .EaseOutQuad:      return CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
            case .EaseInOutQuad:    return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
            case .EaseInCubic:      return CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
            case .EaseOutCubic:     return CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
            case .EaseInOutCubic:   return CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
            case .EaseInQuart:      return CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
            case .EaseOutQuart:     return CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
            case .EaseInOutQuart:   return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
            case .EaseInQuint:      return CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
            case .EaseOutQuint:     return CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
            case .EaseInOutQuint:   return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
            case .EaseInExpo:       return CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
            case .EaseOutExpo:      return CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
            case .EaseInOutExpo:    return CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
            case .EaseInCirc:       return CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
            case .EaseOutCirc:      return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
            case .EaseInOutCirc:    return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
            case .EaseInBack:       return CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
            case .EaseOutBack:      return CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
            case .EaseInOutBack:    return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
                
            case .Custom(let c1x, let c1y, let c2x, let c2y):
                return CAMediaTimingFunction(controlPoints: c1x, c1y, c2x, c2y)
            }
        }
    }
    
    
    // MARK: - RepeatMode
    
    public enum RepeatMode {
        
        case None
        case RepeatDuration(NSTimeInterval)
        case RepeatCount(CGFloat)
        case RepeatForever
    }
    
    
    // MARK: - Public
    
    public static let Default = Options()
    
    public init(timingMode: TimingMode = .Linear, speed: CGFloat = 1, autoreverses: Bool = false, repeatMode: RepeatMode = .None, fillMode: String = kCAFillModeBoth, removedOnCompletion: Bool = false) {
        
        self.timingMode = timingMode
        self.speed = speed
        self.autoreverses = autoreverses
        self.repeatMode = repeatMode
        self.fillMode = fillMode
        self.removedOnCompletion = removedOnCompletion
    }
    
    
    // MARK: Internal
    
    internal let timingMode: TimingMode
    
    internal func applyTo(object: CAAnimation, duration: NSTimeInterval) {
        
        object.timingFunction = self.timingMode.timingFunction
        object.speed = Float(self.speed)
        object.autoreverses = self.autoreverses
        object.fillMode = self.fillMode
        object.removedOnCompletion = self.removedOnCompletion
        
        if duration.isInfinite {
            
            object.duration = DBL_MAX // TODO: duration?
        }
        else if object.autoreverses {
            
            object.duration = duration / 2.0
        }
        else {
            
            object.duration = duration
        }
        
        switch self.repeatMode {
            
        case .None:
            object.repeatCount = 0
            object.repeatDuration = 0
            
        case .RepeatDuration(let repeatDuration):
            object.repeatCount = 0
            object.repeatDuration = repeatDuration
            
        case .RepeatCount(let repeatCount):
            object.repeatCount = Float(repeatCount)
            object.repeatDuration = 0
            
        case .RepeatForever:
            object.repeatCount = Float.infinity
            object.repeatDuration = 0
        }
    }
    
    
    // MARK: Private
    
    private let speed: CGFloat
    private let autoreverses: Bool
    private let repeatMode: RepeatMode
    private let fillMode: String
    private let removedOnCompletion: Bool
}
