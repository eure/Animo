# Animo
[![Version](https://img.shields.io/cocoapods/v/Animo.svg?style=flat)](http://cocoadocs.org/docsets/Animo)
[![Platform](https://img.shields.io/cocoapods/p/Animo.svg?style=flat)](http://cocoadocs.org/docsets/Animo)
[![License](https://img.shields.io/cocoapods/l/Animo.svg?style=flat)](https://raw.githubusercontent.com/eure/Animo/master/LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Bring life to CALayers with SpriteKit-like animation builders.

![preview](https://cloud.githubusercontent.com/assets/3029684/11888561/1df51b40-a582-11e5-85c4-564a7f39ca08.gif)

## Why use Animo?
Because declaring `CAAnimation`s (especially with `CAAnimationGroup`s) is very verbose and tedious.

Animo turns this:
```swift
let positionAnimation = CABasicAnimation(keyPath: "position")
positionAnimation.fromValue = NSValue(CGPoint: fromPoint)
positionAnimation.toValue = NSValue(CGPoint: toPoint)

let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
colorAnimation.fromValue = fromColor.CGColor
colorAnimation.toValue = toColor.CGColor

let animationGroup = CAAnimationGroup()
animationGroup.animations = [positionAnimation, colorAnimation]
animationGroup.fillMode = kCAFillModeForwards
animationGroup.removedOnCompletion = false
animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

someView.layer.addAnimation(animationGroup, forKey: "animationGroup")
```
to this:
```
someView.layer.runAnimation(
    Animo.group(
        Animo.move(from: fromPoint, to: toPoint, duration: 1),
        Animo.keyPath("backgroundColor", from: fromColor, to: toColor, duration: 1),
        timingMode: .EaseInOut,
        options: Options(fillMode: .Forwards)
    )
)
```

## Feature List
- All timing modes from [http://easings.net/](http://easings.net/) are implemented.
- Choose how to mix your animations with grouping utilities:
    - `group(...)`
    - `sequence(...)`
    - `autoreverse(...)`
    - `wait(...)`
    - `replay(...)` and `replayForever(...)`
- No need to box native types and struct types in `NSValue`s! Animo will do that for you for:
    - `Int8`
    - `Int16`
    - `Int32`
    - `Int64`
    - `UInt8`
    - `UInt16`
    - `UInt32`
    - `UInt64`
    - `Int`
    - `UInt`
    - `CGFloat`
    - `Double`
    - `Float`
    - `CGPoint`
    - `CGSize`
    - `CGRect`
    - `CGAffineTransform`
    - `CGVector`
    - `CATransform3D`
    - `UIEdgeInsets`
    - `UIOffset`
    - `NSRange`
- No need to bother between `CGColor` and `UIColor`! Animo automatically converts the following types for you so you can just use UIKit objects all the time:
    - `UIColor` → `CGColor`
    - `UIImage` → `UIImage`
    - `UIBezierPath` → `CGPath`
- Don't bother type-casting `M_PI` anymore and just use Degrees-to-Radians (and vice-versa) extensions for `CGFloat`, `Double`, and `Float`!

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
Add
```
pod 'Animo'
```
to your `Podfile` and run `pod install`

### Install with Carthage
Add
```
github "eure/Animo" >= 1.1.0
```
to your `Cartfile` and run `carthage update`

### Install as Git Submodule
Run
```
git submodule add https://github.com/eure/Animo.git <destination directory>
```

#### To install as a framework:
Drag and drop **Animo.xcodeproj** to your project.

#### To include directly in your app module:
Add all *.swift* files to your project.


## License

Animo is released under an MIT license. See the LICENSE file for more information.
