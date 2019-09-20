//
//  PKColor.swift
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
    
    /// Seperator line color 
    static var seperator: UIColor {
        return UIColor(white: 0.4, alpha: 0.15)
    }
    
    /// Generate color from Alert Style
    /// 
    /// - Parameter style: `PokerAlertView` confirm button style
    ///
    /// - Returns: The created UIColor instance.
    static func fromAlertView(_ style: PokerStyle) -> UIColor {
        switch style {
        case .default: return PKColor.blue
        case .primary: return PKColor.blue
        case .info: return PKColor.teal
        case .warn: return PKColor.orange
        case .danger: return PKColor.red
        case .success: return PKColor.green
        case .color(let color): return color
        }
    }
}

// MARK:- System Color Preset
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
