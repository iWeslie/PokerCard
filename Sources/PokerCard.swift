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

/// Present and basic style of `PokerAlertView` with popup animation from bottom
///
/// There are only two style of `PokerAlertView`, `default` style and `promotion` style, you can customize
/// confirmButton colors, inputView appearance and promotion background color now with `PokerPresenter`'s
/// appearance method
///
/// **Example:**
/// ```
/// PokerCard.showAlert(title: "hey", detail: "Please notice")
/// .appearance { alertView in
///     alertView.confitmButton.backgroundColor = UIColor.gray
/// }
/// ```
///
/// - Parameter title:  The alert title
/// - Parameter detail: The alert detail description, `nil` by default
///
/// - Returns: The created `PokerAlertView` instance.
@discardableResult
public func showAlert(title: String, detail: String? = nil) -> PokerPresenter {
    return PokerPresenter(title: title, detail: detail)
}

//@discardableResult
//public func showInput(title: String, detail: String? = nil) -> PokerPresenter {
//    return PokerPresenter().showAlert(title: title, detail: detail)
//}
