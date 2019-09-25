//
//  PokerInputPresenter.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/21.
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

public class PokerInputPresenter {
    
    public enum Style {
        case `default`
        case promotion
    }
    
    var pokerInputView: PokerInputView!
    
    private static var inputText: ((_ text: String) -> Void)!
    private static var validation: ((_ text: String) -> Bool)?
    
    /// Create a `PokerInputView` with title, detail, button style and input placeholder.
    ///
    /// - Parameter title: The alert title.
    /// - Parameter detail: The alert detail description, `nil` by default.
    /// - Parameter style: The input style, `default` or `promotion`.
    /// - Parameter placeholder: The input placeholder.
    public init(
        style: PokerInputPresenter.Style,
        title: String,
        promotion: String? = nil,
        detail: String?)
    {
        guard let keyWindow = currentWindow else { return }
        let backgroundView = PokerPresenterView(frame: keyWindow.frame)
        keyWindow.addSubview(backgroundView)
        
        if style == .default {
            pokerInputView = PokerInputView(title: title, detail: detail, style: .warn)
        } else if style == .promotion {
            pokerInputView = PokerInputView(title: title, promotion: promotion, secondary: detail, style: .warn)
        }
        let pokerView: PokerInputView = pokerInputView
         
        backgroundView.addSubview(pokerView)
        backgroundView.pokerView = pokerView
        
        // default action, confirm to dismiss
        pokerView.confirmButton.addTarget(pokerView, action: #selector(pokerInputView.dismiss), for: .touchUpInside)
        
        // animations
        pokerView.center = CGPoint(x: backgroundView.frame.width / 2, y: backgroundView.frame.height + 50)
        pokerView.alpha = 0
        UIView.animate(withDuration: 0.25) { pokerView.alpha = 1 }
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 18, options: [], animations: {
            pokerView.center = backgroundView.center
        }, completion: nil)
    }
    
    /// Modify confirm button title and background style.
    ///
    /// - Parameter title: The button title.
    /// - Parameter style: The button color style, **blue** by default, see `PKColor` for more detail.
    /// - Parameter fill: The botton fill style, `true` by default.
    ///
    /// - Returns: The `PokerAlertView` instance.
    @discardableResult
    public func confirm(title: String, style: PokerStyle = .default, fill: Bool = true) -> PokerInputPresenter {
        
        let confirmButton: UIButton = pokerInputView.confirmButton
        confirmButton.setTitle(title, for: .normal)
        confirmButton.backgroundColor = PKColor.fromAlertView(style)
        
        if !fill {
            confirmButton.backgroundColor = UIColor.clear
            confirmButton.layer.borderColor = PKColor.fromAlertView(style).cgColor
            confirmButton.layer.borderWidth = 1
            confirmButton.setTitleColor(PKColor.fromAlertView(style), for: .normal)
        }
        
        return self
    }
    
    /// Add action to confitm button.
    ///
    /// - Parameter handler: The button click action.
    @discardableResult
    public func confirm(_ handler: @escaping (_ text: String) -> Void) -> PokerInputPresenter {
        PokerInputPresenter.inputText = handler
        
        pokerInputView.confirmButton.removeTarget(pokerInputView, action: #selector(pokerInputView.dismiss), for: .touchUpInside)
        pokerInputView.confirmButton.addTarget(PokerInputPresenter.self, action: #selector(PokerInputPresenter.submitInput(_:)), for: .touchUpInside)
        
        return self
    }
    
    @objc
    private static func submitInput(_ sender: UIButton) {
        guard let superView = sender.superview, let inputView = superView as? PokerInputView else { return }
        guard let text = inputView.inputTextField.text, !text.isEmpty else {
            inputView.shakeInputView()
            return
        }
        
        if let validation = PokerInputPresenter.validation {
            if validation(text) {
                inputText(text)
                inputView.dismiss()
            } else {
                inputView.shakeInputView()
            }
        } else {
            inputText(text)
            inputView.dismiss()
        }
    }
    
    /// Modify confirm button style and add action to it.
    ///
    /// - Parameter title:      The button title.
    /// - Parameter style:      The button color style, **blue** by default, see `PKColor` for more detail.
    /// - Parameter handler:    The button click action.
    ///
    /// - Returns: The `PokerInputPresenter` instance.
    @discardableResult
    public func confirm(
        title: String,
        style: PokerStyle = .default,
        fill: Bool = true,
        handler: @escaping (_ text: String) -> Void)
        -> PokerInputPresenter
    {
        confirm(title: title, style: style, fill: fill)
        confirm(handler)
        
        return self
    }
    
    /// Modify promotion area color style and placeholder.
    ///
    /// - Parameter promotionStyle: The promotion color style, **pink** by default, see `PKColor` for more detail.
    /// - Parameter placeholder: The promotion input text filed placeholder
    ///
    /// - Returns: The `PokerInputPresenter` instance.
    @discardableResult
    public func appearance(promotionStyle: PokerStyle, placeholder: String? = nil) -> PokerInputPresenter {
        pokerInputView.promotionContainerView.backgroundColor = PKColor.fromAlertView(promotionStyle).withAlphaComponent(0.1)
        pokerInputView.promotionLeftMarginView?.backgroundColor = PKColor.fromAlertView(promotionStyle)
        
        pokerInputView.inputTextField.placeholder = placeholder
        return self
    }
    
    /// Validate input text by the given predicate closure, shake the input field if validation failed
    ///
    /// - Parameter predicate: The validation predicate closure.
    ///
    /// - Returns: The `PokerInputPresenter` instance.
    @discardableResult
    public func validate(_ predicate: @escaping (String) -> Bool) -> PokerInputPresenter {
        PokerInputPresenter.validation = predicate
        return self
    }

}
