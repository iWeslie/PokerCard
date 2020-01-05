//
//  PokerView.swift
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

internal let baseWidth: CGFloat = 265.0

/// Abstract Class for a Poker Bulletin View
public class PokerView: UIView {
    
    internal let lineSpacing: CGFloat = 8.0
    internal let titleSpacing: CGFloat = 16.0
    internal let internalSpacing: CGFloat = 12.0
    
    /// the top vc in the current view hierarchy
    lazy var topViewController: UIViewController? = {
        guard let rootViewController = currentWindow?.rootViewController else {
            return nil
        }
        
        var topViewController = rootViewController
        while let newTopViewController = topViewController.presentedViewController {
            topViewController = newTopViewController
        }
        return topViewController
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        prepareInterface()
        
        // swipe up to dismiss
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeUp.direction = .up
        self.addGestureRecognizer(swipeUp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Call this method to dismiss Poker View with animation 
    @objc
    public func dismiss(_ sender: UIButton) {
        if let button = sender as? PKButton, button.isConfirmButton {
            UISelectionFeedbackGenerator().selectionChanged()
        }
        
        endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.y = -2 * self.frame.height
        }) { (_) in
            // remove present view from super view
            self.superview?.removeFromSuperview()
        }
    }
    
    fileprivate func prepareInterface() {
        backgroundColor = PKColor.background
            
        layer.cornerRadius = 18
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        
        var resolvedColor = UIColor(white: 0, alpha: 0.3)
        if #available(iOS 13.0, *) {
            let dynamicColor = UIColor { traitCollection -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 0, alpha: 0.7)
                } else {
                    return UIColor(white: 0, alpha: 0.3)
                }
            }
            resolvedColor = dynamicColor.resolvedColor(with: self.traitCollection)
        }
        
        layer.shadowColor = resolvedColor.cgColor
    }
}

/// Abstract Class for a container subview in Poker Bulletin View
internal class PokerSubView: PKContainerView {
    override init() {
        super.init()
        prepareInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func prepareInterface() {
        backgroundColor = PKColor.secondary
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 8
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
        
        var resolvedColor = UIColor(white: 0, alpha: 0.1)
        if #available(iOS 13.0, *) {
            let dynamicColor = UIColor { traitCollection -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 0, alpha: 0.3)
                } else {
                    return UIColor(white: 0, alpha: 0.1)
                }
            }
            resolvedColor = dynamicColor.resolvedColor(with: self.traitCollection)
        }
        
        layer.shadowColor = resolvedColor.cgColor
    }
}
