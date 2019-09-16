//
//  PokerPresenterView.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/16.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

class PokerPresenterView: UIView, UIGestureRecognizerDelegate {
    
    var pokerView: PokerView? {
        didSet {
            guard let pokerView = pokerView else { return }
            
            // tap background to dismiss
            let tap = UITapGestureRecognizer(target: pokerView, action: #selector(pokerView.dismiss))
            tap.delegate = self
            addGestureRecognizer(tap)
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // disbale tap gesture in superview
        let hitPoint = touch.location(in: self)
        if let pokerFrame = pokerView?.frame, pokerFrame.contains(hitPoint) {
            return false
        }
        return true
    }

}
