# 🃏PokerCard

![](https://travis-ci.com/iWeslie/PokerCard.svg?branch=master)
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/PokerCard.svg?style=flat-square)](http://cocoapods.org/pods/PokerCard)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

## OverView

A new generation of an `AlertView` reactive programming UI framework with fluid design interface. Written in purely Swift. Adapted to Dark Mode. 

![poker-alert-preview](https://photos.iweslie.com/github/pokercard/poker-alert-preview.png)

## Example Project

The example project is included in `PokerCard.xcworkspace`, and it contains various examples you can use and modify as you like. 

## Requirements

- iOS 10+
- Xcode 11+
- Swift 5+

> *⚠️PokerCard has not been tested and there is a lack of UITest and other testing cases. This is a pre-release version only⚠️*

## Installation

PokerCard is compatible with Swift 5 as of pre-release 0.1.0.

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. To integrate PokerCard into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'PokerCard'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "iWeslie/PokerCard"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler and Xcode 11+ has integrated it. To add PokerCard as a dependency, navigate to the menu bar, click `File/Swift Packages/Add Package Dependency…` and then input the repository URL: 

```
https://github.com/iWeslie/PokerCard
```

## Basic Usage

```swift
import PokerCard

class ViewController: UIViewController {
    override viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // present a poker card 
        PokerCard.showAlert(title: "Please notice").confirm {
            // do something ...
        }
    }
}
```

### PokerAlertView

![poker-alert](https://photos.iweslie.com/github/pokercard/poker-alert.png)

```swift
PokerCard.showAlert(title: "Please notice", detail: "Here is some descripttion ...")
```

![poker-laert-detail](https://photos.iweslie.com/github/pokercard/poker-laert-detail.png)

Or if you want some customization on the `Confirm` button.

```swift
let detailInfo = "You may configure the alert it as following"
PokerCard.showAlert(title: "The Alert Title", detail: detailInfo)
    .confirm(title: "Done", style: .default, cancelTitle: "Cancel") {
        // do something
}
```

### PokerInputView

#### Default Style

![poker-input](https://photos.iweslie.com/github/pokercard/poker-input.png)

```swift
PokerCard.showInput(title: "Please input your name")
    .confirm(title: "Done", style: .color(.systemPink), cancelTitle: "Cancel") { inputText in 
        print("Hey, \(inputText)!")
}
```

#### Promotion Style

![pker-promotion](https://photos.iweslie.com/github/pokercard/poker-promotion.png)

```swift
let warningInfo = "Some long paragraph of text"
PokerCard.showPromotion(title: "Notice", promotion: warningInfo)
    // modify the promotion preference 
    .appearance(promotionStyle: .color(.systemPink))
    // validate the input string
    .validate { $0.count == 9 }
    // confirm handler 
    .confirm { inputText in 
        print(inputText)
}
```

### PokerAppearanceView

![poker-appearance](https://photos.iweslie.com/github/pokercard/poker-appearance.png)

```swift
// This is only available for iOS 13+
PokerCard.showAppearanceOptions()
    .config(light: {
        print("light selected")
    }, dark: {
        print("dark selected")
    }) {
        print("auto selected")
    }
    .setTitles(title: "Appearance", light: "Light", dark: "Dark", auto: "Auto")
    // add an option for appearance configuration
    .addOption(title: "Show Background Image", isChecked: false) { trigger in
        print("is showing background image: \(trigger)")
        // do some stuff...
    }
```

### PokerContactView

![poker-contact](https://photos.iweslie.com/github/pokercard/poker-contact.png)

```swift
PokerCard.showContacts()
    .config(with: [
        .email("mail"),
        .message("your icloud email"),
        .wechat("your wechat id", wechatLogoImage),
        .weibo(weiboURL, weiboImage),
        .github("github address", githubImage)
    ], on: self)
// you can leave the image nil for `Email` and `Message` option in iOS 13+, it will use sfsymbol automatically.
let emailOption = PKContactOption(type: .email(["domain@example.com"]), image: UIImage(named: "mail"), title: "Email")
let messageOption = PKContactOption(type: .message(["domain@example.com"]), image: UIImage(named: "message"), title: "iMessage")
// Other images should be added into `Assets.xcassets`
let githubOption = PKContactOption(type: .github("iWeslie"), image: UIImage(named: "github"), title: "GitHub")
PokerCard.showContacts()
    .setTitle("Contact Us")
    .addOptions([emailOption, messageOption, githubOption], on: self)
```

### PokerLanguageView

![poker-lang](https://photos.iweslie.com/github/pokercard/poker-lang.png)

```swift
PokerCard.showLanguagePicker()
    .config(en: {
        print("en selected")
    }, zh: {
        print("zh selected")
    }) {
        print("follow system")
    }
    .setTitle("Select Language")
    // These images should also be added into `Assets.xcassets`. You may check it out in Example project.
    .setImages(en: UIImage(named: "enLang")!, zh: UIImage(named: "zhLang")!, auto: UIImage(named: "autoLang")!, checkmark: UIImage(named: "checkmark")!)
```

## Documentation

Documentation will be available soon. You may view the usage inside Xcode.

## Author

Weslie Chen, iwesliechen@gmail.com. WeChat: `weslie-chen`

## License

PokerCard is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
