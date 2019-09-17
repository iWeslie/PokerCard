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
    
    var pokerView: PokerView?
    
    private static var inputText: ((_ text: String) -> Void)!
    
    @discardableResult
    public func showAlert(title: String, detail: String? = nil, style: PokerAlertView.Style = .warn) -> PokerPresenter {
        guard let keyWindow = currentWindow else { return self }
        
        let backgroundView = PokerPresenterView(frame: keyWindow.frame)
        keyWindow.addSubview(backgroundView)
        
//        let pokerView = PokerAlertView(title: title, detail: detail)
//        let pokerView = PokerInputView(title: title, detail: detail, style: .danger, placeholder: "ddd")
        let pokerView = PokerInputView(title: title, promotion: "This is dsfbih vbovbefsdf sdfs df dsf dsfs dfivb w vi dbvid ovbh efn vfvbh ifevn bif", secondary: "sfiuvbefnovebf", placeholder: "febvefiv", style: .danger)
        backgroundView.addSubview(pokerView)
        backgroundView.pokerView = pokerView
        
        pokerView.confirmButton.backgroundColor = PKColor.fromAlertView(style)
        
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
    
    @discardableResult
    public func submit(_ handler: @escaping (_ text: String) -> Void) -> PokerPresenter {
        guard let alertView = self.pokerView as? PokerInputView else {
            preconditionFailure("You must call confirm on a PokerInputView")
        }
        
        PokerPresenter.inputText = handler
        
        alertView.confirmButton.addTarget(PokerPresenter.self, action: #selector(PokerPresenter.submitInput(_:)), for: .touchUpInside)
        
        return self
    }
    
    @objc
    private static func submitInput(_ sender: UIButton) {
        print("hey")
        guard let inputView = sender.superview as? PokerInputView else {
            preconditionFailure("cannot get superview")
        }
        guard let text = inputView.inputTextField.text else { return }
        inputText(text)
        
        inputView.dismiss()
    }
    
}
