A new generation of Alert View with fluid design

# Preview
![poker-alert-preview](https://photos.iweslie.com/github/pokercard/poker-alert-preview.png)

### Basic Usage

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

## PokerAlertView

![poker-alert](https://photos.iweslie.com/github/pokercard/poker-alert.png)

```swift
PokerCard.showAlert(title: "Please notice", detail: "Here is some descripttion ...")
```

![poker-laert-detail](https://photos.iweslie.com/github/pokercard/poker-laert-detail.png)

Or if you want some customization on the `Confirm` button.
```swift
let detailInfo = "You may configure the alert it as following"
PokerCard.showAlert(title: "The Alert Title", detail: detailInfo)
    .confirm(title: "Done", style: .default, fill: false) {
        // do something
    }
```

## PokerInputView

### Default

![poker-input](https://photos.iweslie.com/github/pokercard/poker-input.png)

```swift
PokerCard.showInput(title: "Please input your name")
    .confirm(title: "Done", style: .color(.systemPink)) { inputText in 
        print("Hey, \(inputText)!")
    }
```

### Promotion

![pker-promotion](https://photos.iweslie.com/github/pokercard/poker-promotion.png)

```swift
let warningInfo = "Some long paragraph of text"
PokerCard.showPromotion(title: "Notice", promotion: warningInfo)
    // modify the promotion preference 
    .appearance(promotionStyle: .color(.systemPink))
    // validate the input string
    .validate { $0.count == 11 }
    // confirm handler 
    .confirm { inputText in 
        print(inputText)
    }
```

## PokerAppearanceView

![poker-appearance](https://photos.iweslie.com/github/pokercard/poker-appearance.png)

```swift
PokerCard.showAppearanceOptions()
    .config(light: {
        print("light selected")
    }, dark: {
        print("dark selected")
    }) {
        print("auto selected")
    }
```

## PokerContactView

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
```

## PokerLanguageView

![poker-lang](https://photos.iweslie.com/github/pokercard/poker-lang.png)

```swift
PokerCard.showLanguagePicker()
    .config(en: {
        print("en selected")
    }, zh: {
        print("zh selected")
    }) {
        print("auto selected")
    }
```
