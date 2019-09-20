//
//  PokerPresenter.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/16.
//  Copyright © 2019 Weslie (https://www.iweslie.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public class PokerPresenter {
    
    var pokerAlertView: PokerAlertView!
    
    private static var inputText: ((_ text: String) -> Void)!
    
    /// Create a `PokerAlertView` with title and detail decription.
    ///
    /// - Parameter title:  The alert title
    /// - Parameter detail: The alert detail description, `nil` by default
    public init(title: String, detail: String?) {
        guard let keyWindow = currentWindow else { return }
        let backgroundView = PokerPresenterView(frame: keyWindow.frame)
        keyWindow.addSubview(backgroundView)
        
        /* other styles
        let pokerView = PokerInputView(title: title, detail: detail, style: .danger, placeholder: "ddd")
        let pokerView = PokerInputView(title: title, promotion: "This is bh ifevn bif", secondary: "sfiuvbefnovebf", placeholder: "febvefiv", style: .danger)
        */
        let pokerView = PokerAlertView(title: title, detail: detail)
        backgroundView.addSubview(pokerView)
        backgroundView.pokerView = pokerView
        
        // default action, confirm to dismiss
        pokerView.confirmButton.addTarget(pokerView, action: #selector(pokerAlertView.dismiss), for: .touchUpInside)
        
        // animations
        pokerView.center = CGPoint(x: backgroundView.frame.width / 2, y: backgroundView.frame.height + 50)
        pokerView.alpha = 0
        UIView.animate(withDuration: 0.25) { pokerView.alpha = 1 }
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 18, options: [], animations: {
            pokerView.center = backgroundView.center
        }, completion: nil)
        
        self.pokerAlertView = pokerView
    }
    
    /// Modify confirm button title and background style.
    ///
    /// - Parameter title: The button title
    /// - Parameter style: The button color style, **blue** by default, see `PKColor` for more detail
    ///
    /// - Returns: The `PokerAlertView` instance.
    @discardableResult
    public func confirm(title: String, style: PokerStyle = .default) -> PokerPresenter {
        pokerAlertView.confirmButton.setTitle(title, for: .normal)
        pokerAlertView.confirmButton.backgroundColor = PKColor.fromAlertView(style)
        
        return self
    }
    
    /// Add action to confitm button.
    ///
    /// - Parameter handler: The button click action
    @discardableResult
    public func confirm(_ handler: @escaping () -> Void) -> PokerPresenter {
        // remove default dismiss action
        pokerAlertView.confirmButton.removeTarget(pokerAlertView, action: #selector(pokerAlertView.dismiss), for: .touchUpInside)
        pokerAlertView.confirmButton.touchUpInside(action: handler)
        
        return self
    }
    
    /// Modify confirm button style and add action to it.
    ///
    /// - Parameter title:      The button title
    /// - Parameter style:      The button color style, **blue** by default, see `PKColor` for more detail
    /// - Parameter handler:    The button click action
    @discardableResult
    public func confirm(
        title: String,
        style: PokerStyle = .default,
        handler: @escaping () -> Void)
        -> PokerPresenter
    {
        confirm(title: title, style: style)
        confirm(handler)
        
        return self
    }
    
    
    //------------------ preparing refactor
    @discardableResult
    public func appearance(_ modification: @escaping (PokerAlertView) -> Void) -> PokerPresenter {
        modification(pokerAlertView)
        
        return self
    }
    
    @discardableResult
    public func submit(_ handler: @escaping (_ text: String) -> Void) -> PokerPresenter {
        guard let alertView = self.pokerAlertView as? PokerInputView else {
            preconditionFailure("You must call confirm on a PokerInputView")
        }
        
        PokerPresenter.inputText = handler
        
        alertView.confirmButton.removeTarget(alertView, action: #selector(alertView.dismiss), for: .touchUpInside)
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
