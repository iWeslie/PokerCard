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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        PokerCard.show()
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        button.setTitle("click", for: .normal)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.addTarget(self, action: #selector(popup), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func popup() {
        
//        PokerCard.showAlert(title: "hey").confirm(title: "button title", style: .color(UIColor.systemPurple)) {
//            print("done")
//        }
        
//        PokerCard.showInput(title: "input title").confirm(title: "Submit") { input in
//            print(input)
//        }
        
        let promotion = "This is promotion style of input view, you may call `showInput` for less options.This is promotion style of input view, you may call `showInput` for less options.This is promotion style of input view, you may call `showInput` for less options."
        PokerCard.showPromotion(title: "promotion tile", promotion: promotion, secondaryTitle: "title").appearance(.danger, placeholder: "placeholder").confirm { (text) in
            print(text)
        }
        #warning("secondary = nil will crash")
        
    }
    
}

