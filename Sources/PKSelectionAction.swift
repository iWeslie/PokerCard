//
//  PKSelectionAction.swift
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

/// Poker Action handler
public typealias PKAction = () -> Void

public typealias PKTrigger = (Bool) -> Void

extension PokerAppearanceView {
    /// Passing style change actions by closure.
    ///
    /// - Parameter light:  The light style click action.
    /// - Parameter dark:   The dark style click action.
    /// - Parameter auto:   The auto style click action.
    @discardableResult
    public func config(light: @escaping PKAction, dark: @escaping PKAction, auto: @escaping PKAction) -> PokerAppearanceView {
        lightTapped = light
        darkTapped = dark
        autoTapped = auto
        
        return self
    }
    
    public func addOption(with title: String, trigger: @escaping PKTrigger) {
        optionTitle = title
        optionTrigger = trigger
    }
}

extension PokerContactView {
    /// Configure contact options.
    ///
    /// - Parameter options:    The contact options array.
    /// - Parameter target:     The target controller, use `self` as well.
    public func config(with options: [PKContactOption], on target: UIViewController) {
        contactOptions = options
        targetController = target
    }
}

extension PokerLanguageView {
    /// Passing language change actions by closure.
    ///
    /// - Parameter en: 	English selected.
    /// - Parameter zh:     Simplified Chinses selected.
    /// - Parameter auto:   Auto type language selected.
    public func config(en: @escaping PKAction, zh: @escaping PKAction, auto: @escaping PKAction) {
        enTapped = en
        zhTapped = zh
        autoTapped = auto
    }
}
