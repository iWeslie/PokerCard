//
//  Extension+UIButton.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/16.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// define associated calsses
    private struct AssociatedClass {
        var confirm: ((PokerAlertView) -> Void)? = nil
        var submit: ((String) -> Void)? = nil
    }
    
    /// define associated keys
    private struct AssociateKeys {
        static var eventClosure: AssociatedClass?
    }
    
    /// define click event closure
    private var eventClosureObj: AssociatedClass {
        set(closure) {
            objc_setAssociatedObject(self, &AssociateKeys.eventClosure, closure, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociateKeys.eventClosure) as! AssociatedClass
        }
    }
    
    /// Add touch up inside action to a UIButton instance by a closure at runtime
    internal func addAction(action: @escaping (PokerAlertView) -> Void) {
        eventClosureObj = AssociatedClass(confirm: action)
        
        addTarget(self, action: #selector(excuteEvent(_:)), for: .touchUpInside)
    }
    
    @objc private func excuteEvent(_ sender: UIButton) {
        guard let alertView = sender.superview as? PokerAlertView else {
            preconditionFailure("Cannot get superview")
        }
        
        if let inputView = alertView as? PokerInputView {
            eventClosureObj.submit?(inputView.inputTextField.text ?? "")
        } else {
            eventClosureObj.confirm?(alertView)
        }

        
        alertView.dismiss()
    }
}
