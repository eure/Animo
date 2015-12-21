# Animo
[![Version](https://img.shields.io/cocoapods/v/Animo.svg?style=flat)](http://cocoadocs.org/docsets/Animo)
[![Platform](https://img.shields.io/cocoapods/p/Animo.svg?style=flat)](http://cocoadocs.org/docsets/Animo)
[![License](https://img.shields.io/cocoapods/l/Animo.svg?style=flat)](https://raw.githubusercontent.com/JohnEstropia/Animo/master/LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Bring life to CALayers with SpriteKit-like animation builders.

![preview](https://cloud.githubusercontent.com/assets/3029684/11888561/1df51b40-a582-11e5-85c4-564a7f39ca08.gif)

Animo turns this:
```swift
let positionAnimation = CABasicAnimation(keyPath: "position")
positionAnimation.fromValue = NSValue(CGPoint: fromValue)
positionAnimation.toValue = NSValue(CGPoint: toValue)
positionAnimation.duration = 1
positionAnimation.fillMode = kCAFillModeForwards
positionAnimation.removedOnCompletion = false

someView.layer.addAnimation(positionAnimation, forKey: "bounds")
```
to this:
```
someView.layer.runAnimation(
    Animo.move(
        from: fromValue, to: toValue,
        duration: 1,
        options: Options(fillMode: .Forwards)
    )
)
```

Here's a slightly complex animation that showcases what else you can do with Animo:
```swift
someView.layer.runAnimation(
    Animo.sequence( // Runs a list of animations in sequence
        Animo.wait(1), // Waits for a certain interval before running the next animation
        Animo.replayForever( // Replays the animation endlessly
            Animo.sequence(
                Animo.move( // Moves the layer's position
                    by: CGPoint(x: 100, y: 200), // "by", "from", and "to" arguments are supported
                    duration: 2,
                    timingMode: .Spring(damping: 1) // simplistic spring function that doesn't rely on physics
                ),
                Animo.rotateDegrees( // Rotates the layer (degrees and radians variants are supported)
                    by: -180,
                    duration: 1,
                    timingMode: .EaseInOutBack
                ),
                Animo.autoreverse( // Auto-reverses the animation
                    Animo.keyPath(
                        "cornerRadius", // Any custom KVC key is supported as well!
                        to: 10,
                        duration: 1,
                        timingMode: .EaseInOutBack
                    )
                ),
                Animo.group( // Runs multiple animations together
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
```

### Install with Cocoapods
```
pod 'Animo'
```

### Install with Carthage
```
github "JohnEstropia/Animo" >= 1.0.0
```

### Install as Git Submodule
```
git submodule add https://github.com/JohnEstropia/Animo.git <destination directory>
```
Drag and drop **Animo.xcodeproj** to your project.

#### To install as a framework:
Drag and drop **Animo.xcodeproj** to your project.

#### To include directly in your app module:
Add all *.swift* files to your project.


## License

Animo is released under an MIT license. See the LICENSE file for more information.
