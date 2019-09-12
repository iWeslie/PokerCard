//
//  UIView+KeyWindow.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

/// current keyWindow
public var currentWindow: UIWindow? = {
    if #available(iOS 13.0, *) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first
    } else {
        return UIApplication.shared.keyWindow
    }
}()
