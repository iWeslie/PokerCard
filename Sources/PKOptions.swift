//
//  PKOption.swift
//  PokerCard
//
//  Created by Weslie Chen on 2020/1/7.
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

public protocol PokerOptionBaseElements {
    var title: String { get set }
    var image: UIImage? { get set }
    var action: PKAction? { get set }
    var delay: TimeInterval { get set }
}

public enum PKOption {
    
    public class BaseOption: PokerOptionBaseElements {
        public var title: String
        public var image: UIImage?
        public var action: PKAction?
        public var delay: TimeInterval = 0.0
        
        public init(title: String, image: UIImage?, action: PKAction? = nil) {
            self.title = title
            self.image = image
            self.action = action
        }
    }
    
    public class Contact: BaseOption {
        var type: PKContactType
        
        public init(type: PKContactType, title: String, image: UIImage?) {
            self.type = type
            super.init(title: title, image: image)
        }
    }
    
    public class Auth: BaseOption {
        var type: PKAuthType
        
        public init(type: PKAuthType, title: String, image: UIImage?) {
            self.type = type
            super.init(title: title, image: image)
        }
    }
    
    public class Language: BaseOption {
        var type: PKLangType
        
        public init(type: PKLangType, title: String, image: UIImage?) {
            self.type = type
            super.init(title: title, image: image)
        }
    }
    
}
