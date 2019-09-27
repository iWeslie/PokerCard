//
//  ViewController.swift
//  Example
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit
import PokerCard

class ViewController: UIViewController {
    
    @IBAction func lightStyle(_ sender: Any) {
        if #available(iOS 13.0, *) {
            currentWindow?.overrideUserInterfaceStyle = .light
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
    @IBAction func darkStyle(_ sender: Any) {
        if #available(iOS 13.0, *) {
            currentWindow?.overrideUserInterfaceStyle = .dark
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- Show Alert
    @IBAction func showAlert(_ sender: Any) {
        PokerCard.showAlert(title: "The Alert Title", detail: "Here is some detail information, you may configure the alert view as following...").confirm(title: "Confirm", style: .danger)
    }
    
    // MARK:- Show Input
    @IBAction func showInput(_ sender: Any) {
        let detail = "Optianal detail, leave it or not🤪You may see your name in the consle when clicking confirm"
        
        PokerCard.showInput(title: "Please input your name", detail: detail, placeholder: "Nick name")
        .confirm(title: "Done", style: .warn) { name in
            print("Hey, \(name)!")
        }
    }
    
    // MARK:- Show Prompt
    @IBAction func showPrompt(_ sender: Any) {
        let warning = """
        Warning: The unauthorized reproduction or distribution of this copyrighted work is illegal. Criminal copyright infringement, including infringement without monetary gain, is investigated by the FBI and is punishable by up to five years in federal prison and a fine of $250,000.
        """
        
        PokerCard.showPromotion(title: "FBI WARNING", promotion: warning, secondaryTitle: "Enter Password")
            .appearance(promotionStyle: .color(.systemPink), placeholder: "******")
            .validate(validatePassword(_:))
            .confirm(title: "Enter", style: .primary, fill: false) { _ in
                print("Hello Agent!")
        }
    }
    
    // MARK:- Show Appearance
    @IBAction func showAppearance(_ sender: Any) {
        PokerCard.showAppearanceOptions()
    }
    
    // MARK:- Show Contacts
    @IBAction func showContacts(_ sender: Any) {
        let weiboURL = URL(string: "sinaweibo://userinfo?uid=6425782290")!
        
        let weiboImage = #imageLiteral(resourceName: "weibo")
        let wechatImage = #imageLiteral(resourceName: "wechat")
        let githubImage = #imageLiteral(resourceName: "github")
        
        PokerCard.showContacts()
            .config(with: [.email("mail"),
                           .message("message"),
                           .wechat("id", wechatImage),
                           .weibo(weiboURL, weiboImage),
                           .github("github", githubImage)
            ], on: self)
    }
    
    // MARK:- Show Language Picker
    @IBAction func showLanguagePicker(_ sender: Any) {
        PokerCard.showLanguagePicker()
    }
    
    func validatePassword(_ password: String) -> Bool {
        if password == "123456" {
            return true
        } else {
            return false
        }
    }
    
}
