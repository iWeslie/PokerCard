//
//  PokerTitleRepresentable.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/10/16.
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

protocol PokerTitleRepresentable { }

extension PokerTitleRepresentable {
    internal func setupTitleLabel(for aView: PokerView, with title: String) -> PKLabel {
        let titleLabel = PKLabel(fontSize: 22)
        titleLabel.text = title
        aView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: aView.topAnchor, constant: 16).isActive = true
        titleLabel.constraint(withLeadingTrailing: 16)
        
        return titleLabel
    }
    
    func setupTitleDetailLabels(
        for aView: PokerView,
        title: String,
        detail: String)
    -> (PKLabel, PKLabel) {
        let titleLabel = setupTitleLabel(for: aView, with: title)
        
        let detailLabel = PKLabel(fontSize: 14)
        detailLabel.text = detail
        aView.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        detailLabel.textAlignment = .natural
        detailLabel.constraint(withLeadingTrailing: 16)
        
        return (titleLabel, detailLabel)
    }
}
