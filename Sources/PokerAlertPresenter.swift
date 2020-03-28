//
//  PokerAlertPresenter.swift
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

import UIKit

/// Presenter for Poker View with alert style.
public class PokerAlertPresenter: PokerPresenter {
    /// Create a `PokerAlertView` with title and detail decription.
    ///
    /// - Parameter title:  The alert title.
    /// - Parameter detail: The alert detail description, `nil` by default.
    ///
    /// - Returns: The created `PokerAlertView` instance.
    public func showAlert(title: String, detail: String?) -> PokerAlertView {
        let pokerView = PokerAlertView(title: title, detail: detail)
        backgroundView.pokerView = pokerView
        return pokerView
    }
    
    /// Create a `PokerInputView` with title and detail.
    ///
    /// - Parameter title:  The alert title.
    /// - Parameter detail: The alert detail description, `nil` by default.
    ///
    /// - Returns: The created `PokerInputView` instance.
    public func showInput(title: String, detail: String? = nil) -> PokerInputView {
        let pokerView = PokerInputView(title: title, detail: detail, style: .warn)
        backgroundView.pokerView = pokerView
        return pokerView
    }
    
    /// Create a `PokerInputView` with title, promotion and detail.
    ///
    /// - Parameter title:      The alert title.
    /// - Parameter promotion:  The promotion text.
    /// - Parameter detail:     The alert detail description, `nil` by default.
    public func showPromotion(title: String, promotion: String?, detail: String? = nil) -> PokerInputView {
        let pokerView = PokerInputView(title: title, promotion: promotion, secondary: detail, style: .warn)
        backgroundView.pokerView = pokerView
        return pokerView
    }
    
    /// Create a `PokerDateView` with title and detail decription.
    ///
    /// - Parameter title:  The picker title.
    /// - Parameter detail: The picker detail description, `nil` by default.
    /// - Parameter pickerMode: Mode for UIDatePicker. `time` by default
    ///
    /// - Returns: The created `PokerDateView` instance.
    public func showDatePicker(title: String, detail: String?, pickerMode: UIDatePicker.Mode = .time, defaultTime: Date = Date()) -> PokerDateView {
        let pokerView = PokerDateView(title: title, detail: detail, pickerMode: pickerMode, defaultTime: defaultTime)
        backgroundView.pokerView = pokerView
        return pokerView
    }
}
