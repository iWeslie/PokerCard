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
    
    var containerView: UIView!
    
    convenience init(title: String,
                     detail: String? = nil,
                     style: PokerAlertView.Style = .primary,
                     placeholder: String? = nil) {
        self.init(title: title, detail: detail)
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.systemPink
        addSubview(containerView)
        
        frame.size.height += 200
        
        
//        if let detailLabel = detailLabel {
//            let containerViewAndDetailConstraint = containerView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 8)
//            containerViewAndDetailConstraint.priority = .required
//            containerViewAndDetailConstraint.isActive = true
//        }
//
//        let containerViewAndTitleConstraint = containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
//        containerViewAndTitleConstraint.priority = .defaultLow
//        containerViewAndTitleConstraint.isActive = true
        
        
        
        
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 235, height: 1))
        
        inputTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 235, height: 36))
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height += 100
        containerView.topAnchor.constraint(equalTo: detailLabel!.bottomAnchor).isActive = true
        
        containerView.constraint(withLeadingTrailing: detailHorizontalInset)
        containerView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -12).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    
    
}
