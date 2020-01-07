//
//  PKObjects.swift
//  PokerCard
//
//  Created by Weslie Chen on 2020/1/7.
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

@available(iOS 13.0, *)
let pokerConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)

@available(iOS 13.0, *)
public enum PKSymbol {
    
    public static var checkmark: UIImage? {
        return UIImage(systemName: "checkmark", withConfiguration: pokerConfiguration)
    }
    
    public static var circleArrow: UIImage? {
        return UIImage(systemName: "arrow.2.circlepath", withConfiguration: pokerConfiguration)
    }
    
    public static func name(_ symbolName: String) -> UIImage? {
        return UIImage(systemName: symbolName, withConfiguration: pokerConfiguration)
    }
}



/// `PokerCard` basic label.
class PKLabel: UILabel {
    /// Create a Label.
    /// - Parameter fontSize: label font size
    init(fontSize: CGFloat) {
        super.init(frame: CGRect.zero)
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        textAlignment = .center
        textColor = PKColor.label
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// `PokerCard` basic button.
class PKButton: UIButton {
    
    var isConfirmButton: Bool = false
    
    /// Create a button.
    /// - Parameter title:      the button title.
    /// - Parameter fontSize:   the button title font size.
    init(title: String, fontSize: CGFloat) {
        super.init(frame: CGRect.zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// `PokerCard` basic text field.
class PKTextField: UITextField {
    /// Create a text field.
    /// - Parameter fontSize: the text field font size.
    init(fontSize: CGFloat) {
        super.init(frame: CGRect.zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// `PokerCard` basic container view.
class PKContainerView: UIView {
    /// Create a container view.
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = PKColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
