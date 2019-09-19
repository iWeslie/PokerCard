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
        
//        PokerPresenter().showAlert(title: "Thiss  is an alert", detail: "This is an alers is an alertThiss is an alertThistTh", style: .danger)
        
        PokerCard.showAlert(title: "hey").confirm(title: "button title", style: .color(UIColor.systemPurple)) {
            print("done")
        }
        
//        PokerPresenter().showAlert(title: "asss").appearance { (alertView) in
//            alertView.confirmButton.backgroundColor = UIColor.systemBlue
//        }
        
    }


}

