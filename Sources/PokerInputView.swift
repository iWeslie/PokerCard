//
//  PokerInputView.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/16.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

public class PokerInputView: PokerAlertView {
    
    public var inputTextField: UITextField!
    
    var inputContainerViewHeight: CGFloat = 36
    lazy var inputContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.clear
        container.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(container, at: 0)
        return container
    }()
    
    lazy var promotionContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        return container
    }()
    
    var promotionLabel: UILabel?
    
    convenience init(title: String,
                     detail: String? = nil,
                     style: PokerStyle = .primary,
                     placeholder: String? = nil) {
        self.init(title: title, detail: detail)
        
        setupInputView(with: placeholder)
        
    }
    
    convenience init(title: String, promotion: String? = nil, secondary: String? = nil, placeholder: String? = nil, style: PokerStyle = .default) {
        self.init(title: title, detail: secondary)
        
        setupInputView(with: placeholder)
        setupPromotion(with: promotion, style: style)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
//        _ = layoutViews
    }
    
    private lazy var layoutViews: Void = {
        frame.size.height += inputContainerViewHeight + lineSpacing * 2
    }()
    
    fileprivate func setupInputView(with placeholder: String?) {
        
//        detailBConfirmTCons.isActive = false
        
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.topAnchor.constraint(equalTo: (detailLabel ?? titleLabel).bottomAnchor, constant: lineSpacing).isActive = true
        inputContainerView.constraint(withLeadingTrailing: detailHorizontalInset)
        inputContainerView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -lineSpacing).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: inputContainerViewHeight).isActive = true
        
        frame.size.height += inputContainerViewHeight + lineSpacing * 2
        
        let lineView = UIView()
        lineView.backgroundColor = PKColor.seperator
        lineView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(lineView)
        lineView.constraint(withLeadingTrailing: 0)
        lineView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputTextField = UITextField()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.borderStyle = .none
        inputTextField.placeholder = placeholder
        inputTextField.font = UIFont.systemFont(ofSize: 22, weight: .light)
        inputTextField.textAlignment = .center
        inputContainerView.addSubview(inputTextField)
        inputTextField.constraint(withLeadingTrailing: 0)
        inputTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: lineView.topAnchor).isActive = true
    }
    
    fileprivate func setupPromotion(with promotionText: String?, style: PokerStyle) {
        guard let promotion = promotionText else { return }
        
        titleBDetailTCons.isActive = false
        detailLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
        
        let promotionLabel = UILabel()
        promotionLabel.text = promotion
        promotionLabel.numberOfLines = 0
        promotionLabel.textAlignment = .natural
        promotionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        promotionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.promotionLabel = promotionLabel
        addSubview(promotionLabel)
        
        promotionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        promotionLabel.bottomAnchor.constraint(equalTo: (detailLabel ?? inputContainerView).topAnchor, constant: -12).isActive = true
        promotionLabel.constraint(withLeadingTrailing: 20)
        
        frame.size.height += promotionLabel.estimatedHeight(for: 20) + 28 // 16 + 12
        
        promotionContainerView.backgroundColor = PKColor.pink.withAlphaComponent(0.1)
        promotionContainerView.topAnchor.constraint(equalTo: promotionLabel.topAnchor, constant: -4).isActive = true
        promotionContainerView.bottomAnchor.constraint(equalTo: promotionLabel.bottomAnchor, constant: 4).isActive = true
        promotionContainerView.leadingAnchor.constraint(equalTo: promotionLabel.leadingAnchor, constant: -8).isActive = true
        promotionContainerView.trailingAnchor.constraint(equalTo: promotionLabel.trailingAnchor, constant: 5).isActive = true
        
        let leftMargin = UIView()
        leftMargin.backgroundColor = PKColor.pink
        leftMargin.translatesAutoresizingMaskIntoConstraints = false
        promotionContainerView.addSubview(leftMargin)
        
        leftMargin.leadingAnchor.constraint(equalTo: promotionContainerView.leadingAnchor).isActive = true
        leftMargin.constraint(withTopBottom: 0)
        leftMargin.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
}
