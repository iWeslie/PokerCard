//
//  PokerAuthorizationView.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/12/21.
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

public class PokerAuthorizationView: PokerView, PokerTitleRepresentable {
    
    var enTapped: PKAction?
    var zhTapped: PKAction?
    var autoTapped: PKAction?
    
    internal var titleLabel = PKLabel(fontSize: 20)
    internal var detailLabel: PKLabel?
    
    internal var enLangView = PokerLanguageOptionView(type: .en)
    internal var zhLangView = PokerLanguageOptionView(type: .zh)
    internal var autoLangView = PokerLanguageOptionView(type: .auto)
    
    init() {
        super.init(frame: CGRect.zero)
        
        widthAnchor.constraint(equalToConstant: baseWidth).isActive = true
        titleLabel = setupTitleLabel(for: self, with: "")
        (titleLabel, detailLabel) = setupTitleDetailLabels(for: self, title: "Permission", detail: "This app requeires some authorizations. Please check them below.")
        detailLabel?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
