//
//  PokerCard.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/11.
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

/// Present a basic style of `PokerAlertView` with popup animation from bottom.
///
/// The basic style of `PokerAlertView` contains a title label and detail label, you can customize confirmButton
/// color by calling `confirm(title:style:)`.
///
/// **Example:**
/// ```
/// PokerCard.showAlert(title: "hey", detail: "Please notice")
/// .confirm(title: "Done", style: .default) {
///     print("You've done!")
/// }
/// ```
///
/// - Parameter title:  The alert title.
/// - Parameter detail: The alert detail description, `nil` by default.
///
/// - Returns: The created `PokerAlertView` instance.
@discardableResult
public func showAlert(title: String, detail: String? = nil) -> PokerPresenter {
    return PokerPresenter(title: title, detail: detail)
}

/// Present a common `PokerInputView` with popup animation from bottom.
///
/// This is default style of input view, you may call `showPromotion` for more options
///
/// - Parameter title: The input alert title.
/// - Parameter detail: The input alert detail description, `nil` by default.
///
/// - Returns: The created `PokerInputView` instance.
@discardableResult
public func showInput(title: String, detail: String? = nil, placeholder: String? = nil) -> PokerInputPresenter {
    return PokerInputPresenter(style: .default, title: title, detail: detail)
}

/// Present a promotion `PokerInputView` with popup animation from bottom.
///
/// This is promotion style of input view, you may call `showInput` for less options.
///
/// - Parameter title: The input alert title.
/// - Parameter detail: The input alert detail description, `nil` by default.
///
/// - Returns: The created `PokerInputView` instance.
@discardableResult
public func showPromotion(title: String, promotion: String, secondaryTitle: String? = nil) -> PokerInputPresenter {
    return PokerInputPresenter(style: .promotion, title: title, promotion: promotion, detail: secondaryTitle)
}
