## WolMo - Core iOS
[![Build Status](https://travis-ci.org/Wolox/wolmo-core-ios.svg?branch=master)](https://travis-ci.org/Wolox/wolmo-core-ios)
[![Coverage Status](https://coveralls.io/repos/github/Wolox/wolmo-core-ios/badge.svg?branch=master)](https://coveralls.io/github/Wolox/wolmo-core-ios?branch=master)
[![GitHub release](https://img.shields.io/github/release/Wolox/wolmo-core-ios.svg)](https://github.com/Wolox/wolmo-core-ios/releases)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift 2.3](https://img.shields.io/badge/Swift-2.3-orange.svg)
![Swift 3](https://img.shields.io/badge/Swift-3-orange.svg)

WolMo - Core iOS is a framework which provides extensions and utilities for iOS commonly used at [Wolox](http://www.wolox.com.ar/).


_Note: Swift 2.3 version (in swift-2.3 branch) won't be updated and maintained._

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
To download wolmo-core-iOS, add this to your Cartfile:
```
github "Wolox/wolmo-core-ios" ~> 0.1.0
```

### Manually
[Bootstrap](#bootstrap) the project and then drag it to your workspace.

## Usage

The framework is divided into 2 sections: [Utilities](#utilities) and [Extensions](#extensions).

The main difference between them is that `utilities` represent components that are independent of the existance of another component. On the other hand, `extensions` represent extra functionality for other existent components. Extensions exist only because the components they rely on exists.

### Utilities
Constitutes a component which is independent from another component.

For example, [AlertViewPresenter](Core/Utilities/Alerts/AlertViewPresenter.swift) represents the behaviour of presenting an alert. In this case, any class (struct, enum, etc...) which can adopt this behaviour may be an `AlertViewPresenter`.

In this framework, we give a default implementation of `UIViewController` as an `AlertViewPresenter`. However, note that they are independent one from another.

`Wolmo-core` provides the following utilities:

1. [AlertViewPresenter](Core/Utilities/Alerts/AlertViewPresenter.swift): Abstracts the logic of presenting different type of alerts.
2. [ProgressHUDDelegate](Core/Utilities/ProgressHUD/ProgressHUDDelegate.swift): Abstracts the logic of presenting a progress HUD, usually used in blocking operation (like a sign up).
3. [ActionHandler](Core/Utilities/ActionHandler.swift): Closure-based handlers for UIControlEvents (great for UIButtons).
4. [AssociatedObject](Core/Utilities/AssociatedObject.swift): Setter and getter for associated objects. Works with objects and value types.
5. [CellIdentifiable](Core/Utilities/CellIdentifiable.swift): Identifies a cell. Usually used with `UICollectionView` and `UITableView`.
6. [DeviceType](Core/Utilities/DeviceType.swift): Provides the current device type.
7. [PathAppendable](Core/Utilities/PathAppendable.swift): Makes a component able to be appended to a URL or string.

### Extensions
Extends the behaviour of a component (`class`, `struct`, `enum`, ...) by adding common functionality (functions, computed properties, initializers, ...).

Extensions contain components which depends exclusively on other components.

For example, [Collapsable](Core/Extensions/UIKit/UIView/Collapsable.swift) represents a collapsable element. This behaviour is an addition to a `UIView`; it would not make sense to have something which is not renderable as `Collapsable`. Furthermore, it doesn't make sense for `Collapsable` to exist per se; it is a behaviour added to any view which conforms to it.

`Wolmo-core` provides the following extensions:

1. [ReactiveCocoa](Core/Extensions/ReactiveCocoa): Extensions for [Signal](Core/Extensions/ReactiveCocoa/Signal.swift) and [SignalProducer](Core/Extensions/ReactiveCocoa/SignalProducer.swift).
2. [AVFoundation](Core/Extensions/AVFoundation): Extensions used for AVFoundation elements, such as [AVAsset](Core/Extensions/AVFoundation/AVAsset.swift) and [AVPlayerItem](Core/Extensions/AVFoundation/AVPlayerItem.swift).
3. [UIKit](Core/Extensions/UIKit): Extensions for UIKit elements, such as [UIView](Core/Extensions/UIKit/UIView/UIView.swift) and [UIViewController](Core/Extensions/UIKit/UIViewController.swift).
4. [Foundation](Core/Extensions/Foundation): Extensions for Foundation elements, such as [String](Core/Extensions/Foundation/String.swift), [Array](Core/Extensions/Foundation/Array.swift) and [NSDate](Core/Extensions/Foundation/NSDate.swift).

## Bootstrap
```
git clone git@github.com:Wolox/wolmo-core-ios.git
cd wolmo-core-ios
script/bootstrap
```

## Contributing
1. Fork it
2. [Bootstrap](#bootstrap) using the forked repository (instead of `Wolox/wolmo-core-ios.git`, `your-user/wolmo-core-ios.git`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Run tests (`./script/test`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request

## About

This project is maintained by [Daniela Riesgo](https://github.com/danielaRiesgo) and it is written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)

## License
**WolMo - Core iOS** is available under the MIT [license](LICENSE.txt).

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
