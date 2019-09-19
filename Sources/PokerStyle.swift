//
//  PokerStyle.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/19.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

/// `PokerCard` color style.
public enum PokerStyle {
    
    /// system blue color
    case `default`
    
    /// system blue color, same as default
    case primary
    
    /// system teal color
    case info
    
    /// system orange color
    case warn
    
    /// system red color
    case danger
    
    /// system green color
    case success
    
    /// customize color
    case color(UIColor)
    
}
