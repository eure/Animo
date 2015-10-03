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
                        options: Options(timingMode: .EaseInOutSine)
                    ).autoreverse(),
                    Animate.sequence(
                        [
                            Animate.wait(1),
                            Animate.moveTo(
                                CGPoint(x: 200, y: 100),
                                duration: 1,
                                options: Options(timingMode: .EaseInOutSine)
                            ).autoreverse()
                        ]
                    ),
                    Animate.keyPath(
                        "cornerRadius",
                        to: self.squareView1?.layer.bounds.width ?? 0,
                        duration: 1.5,
                        options: Options(timingMode: .EaseInOutSine)
                    ).autoreverse(),
                    Animate.keyPath(
                        "borderWidth",
                        to: 2,
                        duration: 1.5
                    ).autoreverse(),
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
                ]
            ).repeatForever()
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
                        ]
                    ).repeatForever()
                ]
            )
        )
    }

    @IBOutlet weak var squareView1: UIView?
    @IBOutlet weak var squareView2: UIView?
    
}

