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

@available(iOS 13.0, *)
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
    
    /// Set the appearance option titles.
    ///
    /// - Parameter title:  The PokerView title.
    /// - Parameter light:  The title for light style.
    /// - Parameter dark:   The title for dark style.
    /// - Parameter auto:   The title for auto style.
    ///
    /// - Returns: The `PokerAppearanceView` instance.
    @discardableResult
    public func setTitles(title: String, light: String, dark: String, auto: String) -> PokerAppearanceView {
        titleLabel.text = title
        lightAppearanceView.titleLabel.text = light
        darkAppearanceView.titleLabel.text = dark
        autoAppearanceView.titleLabel.text = auto
        
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
        assert(self.optionTrigger == nil, "Multiple options will be supported in future version")
        
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
    ///
    /// - Returns: The `PokerContactView` instance.
    @discardableResult
    // TODO: - Remove target, compose on custom object.
    public func addOptions(_ options: [PKOption.Contact], on target: UIViewController) -> PokerContactView {
        contactOptions = options
        targetController = target
        
        return self
    }
    
    /// Set the title for the created `PokerContactView` instance.
    ///
    /// - Parameter title: The PokerView title.
    ///
    /// - Returns: The `PokerContactView` instance.
    @discardableResult
    // TODO: - refactor
    public func setTitle(_ title: String) -> PokerContactView {
        titleLabel.text = title
        
        return self
    }
}

extension PokerLanguageView {
    /// Passing language change actions by closure.
    ///
    /// - Parameter en:     English selected.
    /// - Parameter zh:     Simplified Chinses selected.
    /// - Parameter auto:   Auto type language selected.
    ///
    /// - Returns: The `PokerContactView` instance.
    @discardableResult
    public func addLanguages(_ languages: [PKOption.Language]) -> PokerLanguageView {
        langOptions = languages
        
        return self
    }
    
    /// Set the title for the created `PokerLanguageView` instance.
    ///
    /// - Parameter title: The PokerView title.
    ///
    /// - Returns: The `PokerLanguageView` instance.
    @discardableResult
    public func setTitle(_ title: String) -> PokerLanguageView {
        titleLabel.text = title
        
        return self
    }
}

extension PokerAuthorizationView {
    /// Configure auth options.
    ///
    /// You should not grant more than 3 permissions at the same time.
    ///
    /// - Parameter options: The auth options array.
    ///
    /// - Returns: The `PokerAuthorizationView` instance.
    @discardableResult
    public func addOptions(_ options: [PKOption.Auth]) -> PokerAuthorizationView {
        authOptions = options
        return self
    }
    
    /// Set the title for the created `PokerAuthorizationView` instance.
    ///
    /// - Parameter title: The PokerView title.
    ///
    /// - Returns: The `PokerAuthorizationView` instance.
    @discardableResult
    public func setTitle(_ title: String) -> PokerAuthorizationView {
        titleLabel.text = title
        
        return self
    }
}
