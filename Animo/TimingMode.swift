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

import QuartzCore


// MARK: - TimingMode

public enum TimingMode {
    
    
    // MARK: Public
    
    case linear
    case easeIn, easeOut, easeInOut
    case spring(damping: CGFloat)
    case discrete
    
    // http://easings.net/
    case easeInSine, easeOutSine, easeInOutSine
    case easeInQuad, easeOutQuad, easeInOutQuad
    case easeInCubic, easeOutCubic, easeInOutCubic
    case easeInQuart, easeOutQuart, easeInOutQuart
    case easeInQuint, easeOutQuint, easeInOutQuint
    case easeInExpo, easeOutExpo, easeInOutExpo
    case easeInCirc, easeOutCirc, easeInOutCirc
    case easeInBack, easeOutBack, easeInOutBack
    
    case custom(c1x: Float, c1y: Float, c2x: Float, c2y: Float)
    
    
    // MARK: Internal
    
    internal var timingFunction: CAMediaTimingFunction {
        
        switch self {
            
        case .linear:       return CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:       return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:      return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:    return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        case .spring(let damping):    return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + (Float(damping) / 3.0), 1, 1)
        case .discrete:       return CAMediaTimingFunction(controlPoints: 1, 0, 1, 1)
            
            // http://easings.net/
        case .easeInSine:       return CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
        case .easeOutSine:      return CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
        case .easeInOutSine:    return CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)
        case .easeInQuad:       return CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
        case .easeOutQuad:      return CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
        case .easeInOutQuad:    return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
        case .easeInCubic:      return CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
        case .easeOutCubic:     return CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
        case .easeInOutCubic:   return CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
        case .easeInQuart:      return CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
        case .easeOutQuart:     return CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        case .easeInOutQuart:   return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        case .easeInQuint:      return CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
        case .easeOutQuint:     return CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
        case .easeInOutQuint:   return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
        case .easeInExpo:       return CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
        case .easeOutExpo:      return CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
        case .easeInOutExpo:    return CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        case .easeInCirc:       return CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
        case .easeOutCirc:      return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
        case .easeInOutCirc:    return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
        case .easeInBack:       return CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        case .easeOutBack:      return CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        case .easeInOutBack:    return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
            
        case .custom(let c1x, let c1y, let c2x, let c2y):
            return CAMediaTimingFunction(controlPoints: c1x, c1y, c2x, c2y)
        }
    }
}
