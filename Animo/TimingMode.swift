//
//  TimingMode.swift
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

import UIKit


// MARK: - TimingMode

public enum TimingMode {
    
    
    // MARK: Public
    
    case Linear
    case EaseIn, EaseOut, EaseInOut
    case Spring(damping: CGFloat)
    case Discrete
    
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
    
    
    // MARK: Internal
    
    internal var timingFunction: CAMediaTimingFunction {
        
        switch self {
            
        case .Linear:       return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .EaseIn:       return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .EaseOut:      return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .EaseInOut:    return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        case .Spring(let damping):    return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + (Float(damping) / 3.0), 1, 1)
        case .Discrete:       return CAMediaTimingFunction(controlPoints: 1, 0, 1, 1)
            
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
