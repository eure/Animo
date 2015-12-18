# Animo
[![Version](https://img.shields.io/cocoapods/v/Animo.svg?style=flat)](http://cocoadocs.org/docsets/Animo)
[![Platform](https://img.shields.io/cocoapods/p/Animo.svg?style=flat)](http://cocoadocs.org/docsets/Animo)
[![License](https://img.shields.io/cocoapods/l/Animo.svg?style=flat)](https://raw.githubusercontent.com/eure/Animo/master/LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Bring life to CALayers with SpriteKit-like animation builders.

![preview](https://cloud.githubusercontent.com/assets/3029684/11888561/1df51b40-a582-11e5-85c4-564a7f39ca08.gif)

Here's a sneak peak of a slightly complex animation:
```swift
someView.layer.runAnimation(
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
```

### Install with Cocoapods
```
pod 'Animo'
```

### Install with Carthage
```
github "eure/Animo" >= 1.3.0
```

### Install as Git Submodule
```
git submodule add https://github.com/eure/Animo.git <destination directory>
```
Drag and drop **Animo.xcodeproj** to your project.

#### To install as a framework:
Drag and drop **Animo.xcodeproj** to your project.

#### To include directly in your app module:
Add all *.swift* files to your project.


## License

Animo is released under an MIT license. See the LICENSE file for more information.
