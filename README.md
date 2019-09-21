A new generation of Alert View with fluid design

# Preview
![poker-alert-preview](http://photos.iweslie.com/github/pokercard/poker-alert-preview.png)

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

![poker-alert](http://photos.iweslie.com/github/pokercard/poker-alert.png)

```swift
PokerCard.showAlert(title: "Please notice", detail: "Here is some descripttion ...")
```

![poker-laert-detail](http://photos.iweslie.com/github/pokercard/poker-laert-detail.png)

## PokerInputView

### Default

![poker-input](http://photos.iweslie.com/github/pokercard/poker-input.png)

```swift
PokerCard.showInput(title: "Please input your name").submit { inputText in 
    print(inputText)
}
```

### Promotion

![pker-promotion](http://photos.iweslie.com/github/pokercard/poker-promotion.png)

```swift
PokerCard.showPromotion(title: "Notice", promotion: "Detail description").submit { inputText in 
    print(inputText)
}
```

## PokerAppearanceView

![poker-appearance](http://photos.iweslie.com/github/pokercard/poker-appearance.png)

## PokerLanguageView

![poker-lang](http://photos.iweslie.com/github/pokercard/poker-lang.png)

## PokerContactView

![poker-contact](http://photos.iweslie.com/github/pokercard/poker-contact.png)

