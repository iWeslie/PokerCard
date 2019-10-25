//
//  Extension+UIButton.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/16.
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

extension UIButton {
    
    /// define associated calsses
    private struct AssociatedClass {
        var confirm: ((PokerAlertView) -> Void)? = nil
        var submit: ((String) -> Void)? = nil
        var common: (() -> Void)? = nil
    }
    
    /// define associated keys
    private struct AssociateKeys {
        static var eventClosure: AssociatedClass?
        static var buttonCheckStatus = "com.weslie.PokerCard.buttonCheck"
    }
    
    /// define click event closure
    private var eventClosureObj: AssociatedClass {
        set(closure) {
            objc_setAssociatedObject(self, &AssociateKeys.eventClosure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociateKeys.eventClosure) as! AssociatedClass
        }
    }
    
    internal var isChecked: Bool {
        set(value) {
            objc_setAssociatedObject(self, &AssociateKeys.buttonCheckStatus, value, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let value = objc_getAssociatedObject(self, &AssociateKeys.buttonCheckStatus) as? Bool {
                return value
            } else {
                return false
            }
        }
    }
    
    /// Add touch up inside action to a UIButton instance by a closure at runtime
    internal func addAction(action: @escaping (PokerAlertView) -> Void) {
        eventClosureObj = AssociatedClass(confirm: action)
        
        addTarget(self, action: #selector(excuteEvent(_:)), for: .touchUpInside)
    }
    
    /// Add touch up inside action to a UIButton instance by a closure at runtime
    internal func touchUpInside(action: @escaping () -> Void) {
        eventClosureObj = AssociatedClass(common: action)
        
        addTarget(self, action: #selector(excuteEvent(_:)), for: .touchUpInside)
    }
    
    @objc private func excuteEvent(_ sender: UIButton) {
        guard let alertView = sender.superview as? PokerAlertView else {
            // TODO: - debug crash 
            preconditionFailure("Cannot get superview")
        }
        
        if let button = self as? PKButton, button.isConfirmButton {
            UISelectionFeedbackGenerator().selectionChanged()
        }
        
        if let inputView = alertView as? PokerInputView {
            eventClosureObj.submit?(inputView.inputTextField.text ?? "")
        } else {
            eventClosureObj.confirm?(alertView)
            eventClosureObj.common?()
        }

        alertView.dismiss(sender)
    }
}
