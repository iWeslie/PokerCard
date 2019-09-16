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
        
//        PokerPresenter().showAlert(title: "This is an alert", detail: "速递结构和沉稳扽好", style: .warn).confirm { confirmView in
//            print("confirm")
//        }
        
//        PokerPresenter().showAlert(title: "This is an alertThis is an alertThis is an alert", style: .danger)
        PokerPresenter().showAlert(title: "This is an alert", detail: "This is an alertTh", style: .danger)
        
    }


}

