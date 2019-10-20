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
/// Poker Binary Option trigger handler
public typealias PKTrigger = (Bool) -> Void

extension PokerAppearanceView {
    /// Passing style change actions by closure.
    ///
    /// - Parameter light:  The light style click action.
    /// - Parameter dark:   The dark style click action.
    /// - Parameter auto:   The auto style click action.
    ///
    /// - Returns: The `PokerAppearanceView` instance.
    @discardableResult
    public func config(light: @escaping PKAction, dark: @escaping PKAction, auto: @escaping PKAction) -> PokerAppearanceView {
        lightTapped = light
        darkTapped = dark
        autoTapped = auto
        
        return self
    }
    
    @discardableResult
    public func setTitles(title: String, light: String, dark: String, auto: String) -> PokerAppearanceView {
        
        titleLabel.text = title
        lightAppearanceView.titleLabel.text = light
        darkAppearanceView.titleLabel.text = light
        autoAppearanceView.titleLabel.text = light
        return self
    }
    
    @discardableResult
    public func setImages(light: UIImage, dark: UIImage, auto: UIImage) -> PokerAppearanceView {
        lightAppearanceView.symbolImage?.image = light
        darkAppearanceView.symbolImage?.image = dark
        autoAppearanceView.symbolImage?.image = auto
        return self
    }
    
    /// Add theme options for `PokerAppearanceView`
    ///
    /// - Parameter title:      The Option title.
    /// - Parameter isChecked:  The option default check status.
    /// - Parameter trigger:    The trigger for option with a handler.
    ///
    /// - Returns: The `PokerAppearanceView` instance.
    @discardableResult
    public func addOption(title: String, isChecked: Bool, trigger: @escaping PKTrigger) -> PokerAppearanceView {
        // TODO: - should support multiple action
        self.isChecked = isChecked
        optionTrigger = trigger
        optionTitle = title
        
        return self
    }
}

extension PokerContactView {
    /// Configure contact options.
    ///
    /// - Parameter options:    The contact options array.
    /// - Parameter target:     The target controller, use `self` as well.
    @discardableResult
    public func config(with options: [PKContactOption], on target: UIViewController) -> PokerContactView {
        contactOptions = options
        targetController = target
        return self
    }
    
    @discardableResult
    public func setTitle(_ title: String) -> PokerContactView {
        titleLabel.text = title
        return self
    }
}

extension PokerLanguageView {
    /// Passing language change actions by closure.
    ///
    /// - Parameter en: 	English selected.
    /// - Parameter zh:     Simplified Chinses selected.
    /// - Parameter auto:   Auto type language selected.
    @discardableResult
    public func config(en: @escaping PKAction, zh: @escaping PKAction, auto: @escaping PKAction) -> PokerLanguageView {
        enTapped = en
        zhTapped = zh
        autoTapped = auto
        return self
    }
    
    @discardableResult
    public func setTitle(_ title: String) -> PokerLanguageView {
        titleLabel.text = title
        return self
    }
}
