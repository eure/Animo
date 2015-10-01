//
//  ViewController.swift
//  AnimoDemo
//
//  Created by John Rommel Estropia on 2015/09/27.
//  Copyright © 2015 John Rommel Estropia. All rights reserved.
//

import UIKit
import Animo

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.squareView1?.layer.runAnimation(
            Animate.group(
                [
                    Animate.rotateBy(
                        degrees: 360,
                        duration: 1.5,
                        options: Options(repeatMode: .RepeatCount(2))
                    ),
                    Animate.sequence(
                        [
                            Animate.moveTo(
                                CGPoint(x: 200, y: 100),
                                duration: 2,
                                options: Options(
                                    timingMode: .EaseInOutSine,
                                    autoreverses: true
                                )
                            ),
                            Animate.wait(1)
                        ]
                    ),
                    Animate.keyPath(
                        "cornerRadius",
                        to: self.squareView1?.layer.bounds.width ?? 0,
                        duration: 3,
                        options: Options(
                            timingMode: .EaseInOut,
                            autoreverses: true
                        )
                    ),
                    Animate.keyPath(
                        "borderWidth",
                        to: 2,
                        duration: 3,
                        options: Options(autoreverses: true)
                    ),
                    Animate.sequence(
                        [
                            Animate.keyPath(
                                "backgroundColor",
                                from: UIColor.redColor(),
                                to: UIColor.blueColor(),
                                duration: 1,
                                options: Options(timingMode: .EaseInOut)
                            ),
                            Animate.keyPath(
                                "backgroundColor",
                                to: UIColor.yellowColor(),
                                duration: 1,
                                options: Options(timingMode: .EaseInOut)
                            ),
                            Animate.keyPath(
                                "backgroundColor",
                                to: UIColor.redColor(),
                                duration: 1,
                                options: Options(timingMode: .EaseInOut)
                            )
                        ]
                    )
                ],
                normalizeDurations: true,
                duration: 5,
                options: Options(repeatMode: .RepeatForever)
            )
        )
        
        self.squareView2?.layer.runAnimation(
            Animate.sequence(
                [
                    Animate.wait(1),
                    Animate.sequence(
                        [
                            Animate.moveBy(
                                CGPoint(x: 100, y: 200),
                                duration: 2,
                                options: Options(timingMode: .EaseInOutBack)
                            ),
                            Animate.rotateBy(
                                degrees: -180,
                                duration: 1,
                                options: Options(timingMode: .EaseInOutBack)
                            ),
                            Animate.scaleBy(
                                xScale: 2, yScale: 0.5,
                                duration: 1,
                                options: Options(timingMode: .EaseInOutBack)
                            ),
                            Animate.wait(1),
                            Animate.moveBy(
                                CGPoint(x: -100, y: -200),
                                duration: 2,
                                options: Options(timingMode: .EaseInOutBack)
                            ),
                            Animate.rotateBy(
                                degrees: 180,
                                duration: 1,
                                options: Options(timingMode: .EaseInOutBack)
                            ),
                            Animate.scaleTo(
                                xScale: 1, yScale: 1,
                                duration: 1,
                                options: Options(timingMode: .EaseInOutBack)
                            )
                        ],
                        options: Options(
                            repeatMode: .RepeatForever
                        )
                    )
                ]
            )
        )
    }

    @IBOutlet weak var squareView1: UIView?
    @IBOutlet weak var squareView2: UIView?
    
}

