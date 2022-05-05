[![Build Status](https://app.bitrise.io/app/d026a7fe0c9dc2f4/status.svg?token=9MLbGXfHBhZKaL4KXXmpHQ&branch=master)](https://app.bitrise.io/app/d026a7fe0c9dc2f4)
[![License](https://img.shields.io/github/license/wolox/wolmo-core-ios)](https://opensource.org/licenses/MIT)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/WolmoCore)](https://github.com/CocoaPods/CocoaPods)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
![Swift 5](https://img.shields.io/badge/Swift-5-orange?logo=swift)
[![codecov](https://codecov.io/gh/Wolox/wolmo-core-ios/branch/master/graph/badge.svg?token=NwIrvzjHHP)](https://codecov.io/gh/Wolox/wolmo-core-ios)

<p align="center">
  <img height="140px" width="400px" src="https://cloud.githubusercontent.com/assets/4109119/25450281/cac5979e-2a94-11e7-9176-8e323df5dab8.png"/>
</p>

# WOLMO

WOLMO Core iOS is a framework which provides extensions and utilities for iOS commonly used at [Wolox](http://www.wolox.com.ar/).

At Wolox, we complement this framework with [Wolmo - Reactive Core](https://github.com/Wolox/wolmo-reactive-core-ios).

## Table of Contents

  * [Installation](#installation)
    * [CocoaPods](#cocoapods)
    * [Carthage](#carthage)
    * [Manually](#manually)
  * [Usage](#usage)
    * [Documentation](#documentation)
  * [Examples](#examples)
    * [Animations & Gestures](#animations--gestures)
    * [ScrollStack View](#scrollstack-view)
  * [Bootstrap](#bootstrap)
  * [Contributing](#contributing)
  * [About](#about)
  * [License](#license)

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. To use Wolmo Core in your project, update CocoaPods to version 1.10.2 or newer, and add this line to your `Podfile`.

```
pod 'WolmoCore'
```

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

The framework is divided into 2 sections: Utilities and Extensions.

The main difference between them is that `utilities` represent components that are independent of the existance of another component. On the other hand, `extensions` represent extra functionality for other existent components. Extensions exist only because the components they rely on exists.

### Documentation

For more information check out the [WolMo Core Documentation](https://wolox.github.io/wolmo-core-ios/Docs/index.html).

## Examples

### Animations & Gestures

https://user-images.githubusercontent.com/11547820/143459897-e5487095-c404-4b79-a55f-8295685f5f06.mp4

### ScrollStack View

https://user-images.githubusercontent.com/81249698/159357395-8d4cd2a9-c84e-4c3c-b427-322e9673dac9.mp4

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
