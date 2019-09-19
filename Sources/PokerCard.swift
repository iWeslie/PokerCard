//
//  PokerCard.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
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
