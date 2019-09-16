//
//  PKColor.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

/// A color representation attribute as per user interface style
public class PKColor {
    /// Pocker background color
    static var background: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.secondarySystemBackground : UIColor.white
            }
        } else {
            return UIColor.white
        }
    }
    /// Common label color
    static var label: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.white
        }
    }
    
    /// Cancel button color
    static var cancel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.lightGray
        }
    }
}


extension PKColor {
    /// System red color
    static var red: UIColor {
        return UIColor.systemRed
    }
    /// System orange color
    static var orange: UIColor {
        return UIColor.systemOrange
    }
    /// System yellow color
    static var yellow: UIColor {
        return UIColor.systemYellow
    }
    /// System green color
    static var green: UIColor {
        return UIColor.systemGreen
    }
    /// System blue color
    static var blue: UIColor {
        return UIColor.systemBlue
    }
    /// System teal color
    static var teal: UIColor {
        return UIColor.systemTeal
    }
    /// System purple color
    static var purple: UIColor {
        return UIColor.systemPurple
    }
    /// System pink color
    static var pink: UIColor {
        return UIColor.systemPink
    }
}
