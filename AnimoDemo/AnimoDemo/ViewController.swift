//
//  ViewController.swift
//  AnimoDemo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright (c) 2015 eureka, Inc.
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

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.startSqureView1()
        self.startSquareView2()
    }
    

    @IBOutlet weak var squareView1: UIView?
    @IBOutlet weak var squareView2: UIView?
    
    private func startSqureView1() {
        
        self.squareView1?.layer.runAnimation(
            Animo.replayForever(
                Animo.group(
                    Animo.autoreverse(
                        Animo.rotateDegrees(
                            by: 360,
                            duration: 1.5,
                            timingMode: .EaseInOutSine
                        )
                    ),
                    Animo.sequence(
                        Animo.wait(1),
                        Animo.autoreverse(
                            Animo.move(
                                to: CGPoint(x: 200, y: 100),
                                duration: 1,
                                timingMode: .EaseInOutSine
                            )
                        )
                    ),
                    Animo.autoreverse(
                        Animo.keyPath(
                            "cornerRadius",
                            to: self.squareView1?.layer.bounds.width ?? 0,
                            duration: 1.5,
                            timingMode: .EaseInOutSine
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
                            from: UIColor.redColor(),
                            to: UIColor.blueColor(),
                            duration: 1,
                            timingMode: .EaseInOut
                        ),
                        Animo.keyPath(
                            "backgroundColor",
                            to: UIColor.yellowColor(),
                            duration: 1,
                            timingMode: .EaseInOut
                        ),
                        Animo.keyPath(
                            "backgroundColor",
                            to: UIColor.redColor(),
                            duration: 1,
                            timingMode: .EaseInOut
                        )
                    )
                )
            )
        )
    }
    
    private func startSquareView2() {
        
        self.squareView2?.layer.runAnimation(
            Animo.sequence(
                Animo.wait(1),
                Animo.replayForever(
                    Animo.sequence(
                        Animo.move(
                            by: CGPoint(x: 100, y: 200),
                            duration: 2,
                            timingMode: .EaseInOutBack
                        ),
                        Animo.rotateDegrees(
                            by: -180,
                            duration: 1,
                            timingMode: .EaseInOutBack
                        ),
                        Animo.group(
                            Animo.scaleX(
                                by: 2,
                                duration: 1,
                                timingMode: .EaseInOutBack
                            ),
                            Animo.scaleY(
                                by: 0.5,
                                duration: 1,
                                timingMode: .EaseInOutBack
                            )
                        ),
                        Animo.wait(1),
                        Animo.move(
                            by: CGPoint(x: -100, y: -200),
                            duration: 2,
                            timingMode: .EaseInOutBack
                        ),
                        Animo.rotateDegrees(
                            by: 180,
                            duration: 1,
                            timingMode: .EaseInOutBack
                        ),
                        Animo.group(
                            Animo.scaleX(
                                to: 1,
                                duration: 1,
                                timingMode: .EaseInOutBack
                            ),
                            Animo.scaleY(
                                to: 1,
                                duration: 1,
                                timingMode: .EaseInOutBack
                            )
                        )
                    )
                )
            )
        )
    }
}

