[![Build Status](https://app.bitrise.io/app/d026a7fe0c9dc2f4/status.svg?token=9MLbGXfHBhZKaL4KXXmpHQ&branch=master)](https://app.bitrise.io/app/d026a7fe0c9dc2f4)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
![Swift 5](https://img.shields.io/badge/Swift-5-orange?logo=swift)
[![codecov](https://codecov.io/gh/Wolox/wolmo-core-ios/branch/master/graph/badge.svg?token=NwIrvzjHHP)](https://codecov.io/gh/Wolox/wolmo-core-ios)

<p align="center">
  <img height="140px" width="400px" src="https://cloud.githubusercontent.com/assets/4109119/25450281/cac5979e-2a94-11e7-9176-8e323df5dab8.png"/>
</p>

# WOLMO

WOLMO Core iOS is a framework which provides extensions and utilities for iOS commonly used at [Wolox](http://www.wolox.com.ar/).

At Wolox, we complement this framework with [Wolmo - Reactive Core](https://github.com/Wolox/wolmo-reactive-core-ios).

<img src="https://github.com/Wolox/wolmo-core-ios/blob/master/Screenshots/animationDemo.gif"></a>
<br><br/>


## Table of Contents

  * [Installation](#installation)
    * [Carthage](#carthage)
    * [Manually](#manually)
  * [Usage](#usage)
    * [Utilities](#utilities)
    * [Extensions](#extensions)
  * [Bootstrap](#bootstrap)
  * [Contributing](#contributing)
  * [About](#about)
  * [License](#license)

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with Homebrew using the following command:

```
brew update
brew install carthage
```
To download wolmo-core-ios, add this to your Cartfile:
```
github "Wolox/wolmo-core-ios" ~> 4.1.0
```

### Manually
[Bootstrap](#bootstrap) the project and then drag it to your workspace.

## Usage

The framework is divided into 2 sections: [Utilities](#utilities) and [Extensions](#extensions).

The main difference between them is that `utilities` represent components that are independent of the existance of another component. On the other hand, `extensions` represent extra functionality for other existent components. Extensions exist only because the components they rely on exists.

### Utilities
Constitutes a component which is independent from another component.

For example, [AlertViewPresenter](WolmoCore/Utilities/Alerts/AlertViewPresenter.swift) represents the behaviour of presenting an alert. In this case, any class (struct, enum, etc...) which can adopt this behaviour may be an `AlertViewPresenter`.

In this framework, we give a default implementation of `UIViewController` as an `AlertViewPresenter`. However, note that they are independent one from another.

`WolmoCore` provides the following utilities:

1. [AlertViewPresenter](WolmoCore/Utilities/Alerts/AlertViewPresenter.swift): Abstracts the logic of presenting different type of alerts.
2. [AssociatedObject](WolmoCore/Utilities/AssociatedObject.swift): Setter and getter for associated objects. Works with objects and value types.
3. [Identifiable](WolmoCore/Utilities/Identifiable.swift): Identifies a reusable view. Usually used with `UICollectionView` and `UITableView` for cells, headers or footers.
4. [NibLoadable](WolmoCore/Utilities/NibLoadable.swift): Provides a way to load a resource from a nib, through Identifiable. Usually used to load a UIViewcontroller's view from a .xib.
5. [DeviceType](WolmoCore/Utilities/DeviceType.swift): Provides the current device type.
6. [PathAppendable](WolmoCore/Utilities/PathAppendable.swift): Makes a component able to be appended to a URL or string.
and more...

### Extensions
Extends the behaviour of a component (`class`, `struct`, `enum`, ...) by adding common functionality (functions, computed properties, initializers, ...).

Extensions contain components which depends exclusively on other components.

For example, [Collapsable](WolmoCore/Extensions/UIKit/UIView/Collapsable.swift) represents a collapsable element. This behaviour is an addition to a `UIView`; it would not make sense to have something which is not renderable as `Collapsable`. Furthermore, it doesn't make sense for `Collapsable` to exist per se; it is a behaviour added to any view which conforms to it.

`WolmoCore` provides the following extensions:

1. [AVFoundation](WolmoCore/Extensions/AVFoundation): Extensions used for AVFoundation elements, such as [AVAsset](WolmoCore/Extensions/AVFoundation/AVAsset.swift) and [AVPlayerItem](WolmoCore/Extensions/AVFoundation/AVPlayerItem.swift).
2. [UIKit](WolmoCore/Extensions/UIKit): Extensions for UIKit elements, such as [UIView](WolmoCore/Extensions/UIKit/UIView/UIView.swift) and [UIViewController](WolmoCore/Extensions/UIKit/UIViewController.swift).
3. [Foundation](WolmoCore/Extensions/Foundation): Extensions for Foundation elements, such as [String](WolmoCore/Extensions/Foundation/String.swift), [Array](WolmoCore/Extensions/Foundation/Array.swift) and [Date](WolmoCore/Extensions/Foundation/Date.swift).
4. [Animations](WolmoCore/Extensions/Animations): Extensions for `UIView` to animate it easily, such as [SimpleAnimation](WolmoCore/Extensions/Animations/SimpleAnimation.swift), [MixedAnimation](WolmoCore/Extensions/Animations/MixedAnimation.swift) and [ChainedAnimation](WolmoCore/Extensions/Animations/ChainedAnimation.swift)

You can check in the [AnimationDemo](AnimationDemo/ViewController.swift) the contrast between the normal way of doing animations and our way.
You can see examples of simple animations and one complex animation.
Moreover, you can check some cases which does not work as expected with our extensions so you don't run into those problems.

## Bootstrap
```
git clone git@github.com:Wolox/wolmo-core-ios.git
cd wolmo-core-ios
script/bootstrap
```

## Contributing
1. Clone it
2. [Bootstrap](#bootstrap) the repository
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Run tests (`./script/test`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request to the repository

## About

This project is maintained by [Wolox](http://www.wolox.com.ar).

<img height="100px" src="https://user-images.githubusercontent.com/11547820/142273110-5fb5be3f-e215-41af-844d-343a6134d80c.png"/>

## License
**WolMo - Core iOS** is available under the [MIT license](LICENSE.txt).

    Copyright (c) 2016 Francisco Depascuali <francisco.depascuali@wolox.com.ar>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
