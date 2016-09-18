//
//  ViewController.swift
//  AnimoDemo
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
import Animo


// MARK: - ViewController

final class ViewController: UIViewController {
    
    
    // MARK: UIViewController

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.startSqureView1()
        self.startSquareView2()
        
        
        let fromPoint = CGPoint(x: 0, y: 0)
        let toPoint = CGPoint(x: 20, y: 20)
        
        let fromColor = UIColor.red
        let toColor = UIColor.blue
        
        let someView = UIView()
        
        
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.duration = 1
        positionAnimation.fromValue = NSValue(cgPoint: fromPoint)
        positionAnimation.toValue = NSValue(cgPoint: toPoint)
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.duration = 1
        colorAnimation.fromValue = fromColor.cgColor
        colorAnimation.toValue = toColor.cgColor
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [positionAnimation, colorAnimation]
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        someView.layer.add(animationGroup, forKey: "animationGroup")
        
        
        _ = someView.layer.runAnimation(
            Animo.group(
                Animo.move(from: fromPoint, to: toPoint, duration: 1),
                Animo.keyPath("backgroundColor", from: fromColor, to: toColor, duration: 1),
                timingMode: .easeInOut,
                options: Options(fillMode: .forwards)
            )
        )
    }
    
    
    // MARK: Private

    @IBOutlet private dynamic weak var squareView1: UIView?
    @IBOutlet private dynamic weak var squareView2: UIView?
    
    private func startSqureView1() {
        
        _ = self.squareView1?.layer.runAnimation(
            Animo.replayForever(
                Animo.group(
                    Animo.autoreverse(
                        Animo.rotateDegrees(
                            by: 360,
                            duration: 1.5,
                            timingMode: .easeInOutSine
                        )
                    ),
                    Animo.sequence(
                        Animo.wait(1),
                        Animo.autoreverse(
                            Animo.move(
                                to: CGPoint(x: 200, y: 100),
                                duration: 1,
                                timingMode: .easeInOutSine
                            )
                        )
                    ),
                    Animo.autoreverse(
                        Animo.keyPath(
                            "cornerRadius",
                            to: self.squareView1?.layer.bounds.width ?? 0,
                            duration: 1.5,
                            timingMode: .easeInOutSine
                        )
                    ),
                    Animo.autoreverse(
                        Animo.keyPath(
                            "borderWidth",
                            to: 2,
                            duration: 1.5
                        )
                    ),
                    Animo.sequence(
                        Animo.keyPath(
                            "backgroundColor",
                            from: UIColor.red,
                            to: UIColor.blue,
                            duration: 1,
                            timingMode: .easeInOut
                        ),
                        Animo.keyPath(
                            "backgroundColor",
                            to: UIColor.yellow,
                            duration: 1,
                            timingMode: .easeInOut
                        ),
                        Animo.keyPath(
                            "backgroundColor",
                            to: UIColor.red,
                            duration: 1,
                            timingMode: .easeInOut
                        )
                    )
                )
            )
        )
    }
    
    private func startSquareView2() {
        
        _ = self.squareView2?.layer.runAnimation(
            Animo.sequence(
                Animo.wait(1),
                Animo.replayForever(
                    Animo.sequence(
                        Animo.move(
                            by: CGPoint(x: 100, y: 200),
                            duration: 2,
                            timingMode: .easeInOutBack
                        ),
                        Animo.rotateDegrees(
                            by: -180,
                            duration: 1,
                            timingMode: .easeInOutBack
                        ),
                        Animo.group(
                            Animo.scaleX(
                                by: 2,
                                duration: 1,
                                timingMode: .easeInOutBack
                            ),
                            Animo.scaleY(
                                by: 0.5,
                                duration: 1,
                                timingMode: .easeInOutBack
                            )
                        ),
                        Animo.wait(1),
                        Animo.move(
                            by: CGPoint(x: -100, y: -200),
                            duration: 2,
                            timingMode: .easeInOutBack
                        ),
                        Animo.rotateDegrees(
                            by: 180,
                            duration: 1,
                            timingMode: .easeInOutBack
                        ),
                        Animo.group(
                            Animo.scaleX(
                                to: 1,
                                duration: 1,
                                timingMode: .easeInOutBack
                            ),
                            Animo.scaleY(
                                to: 1,
                                duration: 1,
                                timingMode: .easeInOutBack
                            )
                        )
                    )
                )
            )
        )
    }
}

