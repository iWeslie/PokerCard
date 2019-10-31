//
//  PKAlertAction.swift
//  PokerCard
//
//  Created by Weslie on 2019/10/6.
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

import Foundation
import UIKit

extension PokerAlertView {
    /// Modify confirm button title and background style.
    ///
    /// - Parameter title:          The button title.
    /// - Parameter style:          The button color style, **blue** by default, see `PKColor` for more detail.
    /// - Parameter fill:           The button fill style, default is `true`.
    /// - Parameter cancelTitle:    The cancel button title, `nil` by default.
    ///
    /// - Returns: The `PokerAlertView` instance.
    @discardableResult
    public func confirm(title: String, style: PokerStyle = .default, fill: Bool = true, cancelTitle: String? = nil) -> PokerAlertView {
        confirmButton.setTitle(title, for: .normal)
        confirmButton.backgroundColor = PKColor.fromAlertView(style)
        setupCancelButton(with: cancelTitle)
        
        if !fill {
            confirmButton.backgroundColor = PKColor.clear
            confirmButton.layer.borderColor = PKColor.fromAlertView(style).cgColor
            confirmButton.layer.borderWidth = 1
            confirmButton.setTitleColor(PKColor.fromAlertView(style), for: .normal)
        }
        
        return self
    }
    
    /// Add action to confitm button.
    ///
    /// - Parameter handler: The button click action.
    ///
    /// - Returns: The `PokerAlertView` instance.
    @discardableResult
    fileprivate func confirm(_ handler: @escaping () -> Void) -> PokerAlertView {
        // remove default dismiss action
        confirmButton.removeTarget(self, action: #selector(dismiss), for: .touchUpInside)
        confirmButton.touchUpInside(action: handler)
        
        return self
    }
    
    /// Modify confirm button style and add action to it.
    ///
    /// - Parameter title:          The button title.
    /// - Parameter style:          The button color style, **blue** by default, see `PKColor` for more detail.
    /// - Parameter handler:        The button click action.
    /// - Parameter fill:           The button fill style, default is `true`
    /// - Parameter cancelTitle:    The cancel button title, `nil` by default.
    ///
    /// - Returns: The `PokerAlertView` instance.
    @discardableResult
    public func confirm(
        title: String,
        style: PokerStyle = .default,
        fill: Bool = true,
        cancelTitle: String? = nil,
        handler: @escaping () -> Void)
        -> PokerAlertView
    {
        confirm(title: title, style: style, fill: fill, cancelTitle: cancelTitle)
        confirm(handler)
        
        return self
    }
}

extension PokerInputView {
    /// Add action to confitm button.
    ///
    /// - Parameter handler: The button click action.
    ///
    /// - Returns: The `PokerInputView` instance.
    @discardableResult
    public func confirm(_ handler: @escaping (_ text: String) -> Void) -> PokerInputView {
        inputText = handler
        
        confirmButton.removeTarget(self, action: #selector(dismiss), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(submitInput(_:)), for: .touchUpInside)
        
        return self
    }
    
    @objc
    private func submitInput(_ sender: PKButton) {
        guard let superView = sender.superview, let inputView = superView as? PokerInputView else { return }
        guard let text = inputView.inputTextField.text, !text.isEmpty else {
            inputView.shakeInputView()
            return
        }
        
        if let validation = validation {
            if validation(text) {
                inputText(text)
                inputView.dismiss(sender)
            } else {
                inputView.shakeInputView()
            }
        } else {
            inputText(text)
            inputView.dismiss(sender)
        }
    }
    
    /// Modify confirm button style and add action to it.
    ///
    /// - Parameter title:      The button title.
    /// - Parameter style:      The button color style, **blue** by default, see `PKColor` for more detail.
    /// - Parameter handler:    The button click action.
    /// - Parameter fill: The button fill style, default is `true`.
    /// - Parameter cancelTitle: The cancel button title, `nil` by default.
    ///
    /// - Returns: The `PokerInputView` instance.
    @discardableResult
    public func confirm(
        title: String,
        style: PokerStyle = .default,
        fill: Bool = true,
        cancelTitle: String?,
        handler: @escaping (_ text: String) -> Void)
        -> PokerInputView
    {
        confirm(title: title, style: style, fill: fill, cancelTitle: cancelTitle)
        confirm(handler)
        
        return self
    }
    
    /// Validate input text by the given predicate closure, shake the input field if validation failed
    ///
    /// - Parameter predicate: The validation predicate closure.
    ///
    /// - Returns: The `PokerInputView` instance.
    @discardableResult
    public func validate(_ predicate: @escaping (String) -> Bool) -> PokerInputView {
        validation = predicate
        
        return self
    }
    
    /// Modify promotion area color style and placeholder.
    ///
    /// - Parameter promotionStyle: The promotion color style, **pink** by default, see `PKColor` for more detail.
    /// - Parameter placeholder: The promotion input text filed placeholder
    ///
    /// - Returns: The `PokerInputView` instance.
    @discardableResult
    public func appearance(promotionStyle: PokerStyle, placeholder: String? = nil) -> PokerInputView {
        promotionContainerView.backgroundColor = PKColor.fromAlertView(promotionStyle).withAlphaComponent(0.1)
        promotionLeftMarginView.backgroundColor = PKColor.fromAlertView(promotionStyle)
        inputTextField.placeholder = placeholder
        
        return self
    }
    
    /// Regisiter the input view to first responder when popup.
    ///
    /// - Returns: The `PokerInputView` instance.
    @discardableResult
    public func shouldBecomeFirstResponder() -> PokerInputView {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.inputTextField.becomeFirstResponder()
        }
        
        return self
    }
}
