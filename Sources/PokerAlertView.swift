//
//  PokerAlertView.swift
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

import UIKit

/// Base Poker Alert View
public class PokerAlertView: PokerView {
    
    public var titleLabel: UILabel!
    public var detailLabel: UILabel?
    public var confirmButton: UIButton!
    internal var cancelButton: UIButton!
    
    internal var titleHorizontalInset: CGFloat = 24
    internal var titleVerticalInset: CGFloat = 18
    internal var detailHorizontalInset: CGFloat = 15
    internal var buttonHorizontalInset: CGFloat = 40
    internal var lineSpacing: CGFloat = 8
    
    var titleBDetailTCons: NSLayoutConstraint?
    var titleBConfirmTCons: NSLayoutConstraint!
    var detailBConfirmTCons: NSLayoutConstraint!
    
//    public convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style)
    
    public convenience init(title: String, detail: String? = nil) {
        self.init()
        
        frame.size.width = 265
        frame.size.height = 134
        
        backgroundColor = PKColor.background
        
        setupLabel(with: title)
        setupConfirmCancelButton()
        setupDetail(with: detail)
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        _ = layoutViews
    }
    
    private lazy var layoutViews: Void = {
        confirmButton.layer.cornerRadius = confirmButton.frame.height / 2
        
        // resize title label
        // offset = estimated - original
        //
        // height = height - original + estimated
        // height -= original - estimated
        frame.size.height -= titleLabel.frame.height - titleLabel.estimatedHeight(for: titleHorizontalInset)
        if let detailLabel = detailLabel {
            frame.size.height -= detailLabel.frame.height - detailLabel.estimatedHeight(for: detailHorizontalInset)
        }
        
        // align to center
        guard let superView = self.superview else {
            preconditionFailure("cannot get superview")
        }
        frame.origin.y = superView.frame.midY - frame.size.height / 2
    }()
    
    private func setupLabel(with title: String) {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .light)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = PKColor.label
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        titleLabel.constraint(withLeadingTrailing: titleHorizontalInset)
        
    }
    
    private func setupDetail(with detail: String?) {
        guard let detail = detail, !detail.isEmpty else { return }
        
        detailLabel = UILabel()
        detailLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        detailLabel?.text = detail
        detailLabel?.numberOfLines = 0
        detailLabel?.textAlignment = detailLabel?.numberOfLines == 1 ? .center : .left
        detailLabel?.textColor = PKColor.label
        detailLabel?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailLabel!)
        
        titleBDetailTCons = detailLabel?.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        titleBDetailTCons?.isActive = true
        detailLabel?.constraint(withLeadingTrailing: detailHorizontalInset)
        
        detailBConfirmTCons = detailLabel?.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -12)
        detailBConfirmTCons?.priority = .defaultHigh
        detailBConfirmTCons?.isActive = true
        
        titleBConfirmTCons.isActive = false
    }
    
    private func setupConfirmCancelButton() {
        confirmButton = UIButton()
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        confirmButton.backgroundColor = PKColor.blue
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(confirmButton)
        
        titleBConfirmTCons = confirmButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleVerticalInset)
        titleBConfirmTCons.priority = .defaultHigh
        titleBConfirmTCons.isActive = true
        
        confirmButton.constraint(withLeadingTrailing: buttonHorizontalInset)
        confirmButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        cancelButton = UIButton()
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(PKColor.cancel, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        
        cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 88).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        cancelButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
}

extension UIView {
    /// Set leading and trailing anchor
    internal func constraint(withLeadingTrailing inset: CGFloat) {
        guard let superView = self.superview else { return }
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -inset).isActive = true
    }
    
    /// Set leading and trailing anchor
    internal func constraint(withTopBottom inset: CGFloat) {
        guard let superView = self.superview else { return }
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: inset).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -inset).isActive = true
    }
    
    /// Set width and height anchor
    internal func constraint(withWidthHeight constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    /// Set width and height anchor equal
    internal func constraint(equalWidthHeight toView: UIView) {
        self.heightAnchor.constraint(equalTo: toView.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: toView.widthAnchor).isActive = true
    }
    
    /// Set equal width and height with center baseline
    internal func constraint(horizontalStack toView: UIView) {
        self.constraint(equalWidthHeight: toView)
        self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
    }
    
    /// Set equal width and height with center vertical
    internal func constraint(verticalStack toView: UIView) {
        self.constraint(equalWidthHeight: toView)
        self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
    }
}

extension UILabel {
    /// Calculate label's intrisic content height with horizontal inset in superview
    internal func estimatedHeight(for horizontalInset: CGFloat) -> CGFloat {
        guard let superView = self.superview else { return 0 }
        let labelWidth = superView.frame.width - 2 * horizontalInset
        self.preferredMaxLayoutWidth = labelWidth
        return self.intrinsicContentSize.height
    }
}
