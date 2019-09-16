//
//  PokerPresenter.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/16.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

public class PokerPresenter {
    
    public init() { }
    
    var pokerView: PokerView? {
        didSet {
            
        }
    }
    
    @discardableResult
    public func showAlert(title: String, detail: String? = nil, style: PokerAlertView.Style = .warn) -> PokerPresenter {
        guard let keyWindow = currentWindow else { return self }
        
        let backgroundView = PokerPresenterView(frame: keyWindow.frame)
        keyWindow.addSubview(backgroundView)
        
        // load popupView
        let pokerView = PokerAlertView(title: title, detail: detail)
//        let pokerView = PokerInputView(title: title, detail: detail, style: .danger, placeholder: "ddd")
        backgroundView.addSubview(pokerView)
        backgroundView.pokerView = pokerView
        
        var color = PKColor.cancel
        switch style {
        case .danger: color = PKColor.red
        case .default: color = PKColor.cancel
        case .info: color = PKColor.teal
        case .primary: color = PKColor.blue
        case .success: color = PKColor.green
        case .warn: color = PKColor.orange
        }
        pokerView.confirmButton.backgroundColor = color
        
        // animation
        pokerView.center = CGPoint(x: backgroundView.frame.width / 2, y: backgroundView.frame.height + 50)
        pokerView.alpha = 0
        UIView.animate(withDuration: 0.25) { pokerView.alpha = 1 }
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 18, options: [], animations: {
            pokerView.center = backgroundView.center
        }, completion: nil)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
//
//        }
        
        self.pokerView = pokerView
        
        return self
    }
    
    @discardableResult
    public func appearance(_ modification: @escaping (PokerAlertView) -> Void) -> PokerPresenter {
        guard let alertView = self.pokerView as? PokerAlertView else {
            preconditionFailure("You must call confirm on a PokerAlertView")
        }
        modification(alertView)
        
        return self
    }
    
    @discardableResult
    public func confirm(_ handler: @escaping (PokerAlertView) -> Void) -> PokerPresenter {
        guard let alertView = self.pokerView as? PokerAlertView else {
            preconditionFailure("You must call confirm on a PokerAlertView")
        }
        alertView.confirmButton.addAction(action: handler)
        
        return self
    }
    
}
