//
//  PokerAlertView.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

/// base Poker Alert View
public class PokerAlertView: PokerView {
    
    var titleLabel: UILabel!
    var confirmButton: UIButton!
    var cancelButton: UIButton!
    
    private var titleHorizontalInset: CGFloat = 24
    private var titleVerticalInset: CGFloat = 18
    private var buttonHorizontalInset: CGFloat = 40
    
    private var titleLabelEstimatedHeight: CGFloat {
        get {
            let labelWidth = frame.width - 2 * titleHorizontalInset
            titleLabel.preferredMaxLayoutWidth = labelWidth
            return titleLabel.intrinsicContentSize.height
        }
    }
    
//    public convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style)
    
    public convenience init(title: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 265, height: 159))
        
        backgroundColor = PKColor.background
        
        setupLabel(with: title)
        setupConfirmCancelButton()
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        confirmButton.layer.cornerRadius = confirmButton.frame.height / 2
    }
    
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
    
    private func setupConfirmCancelButton() {
        confirmButton = UIButton()
        confirmButton.backgroundColor = PKColor.blue
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(confirmButton)
        
        confirmButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleVerticalInset).isActive = true
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
    /// set leading and trailing anchor
    func constraint(withLeadingTrailing inset: CGFloat) {
        guard let superView = self.superview else { return }
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -inset).isActive = true
    }
}
