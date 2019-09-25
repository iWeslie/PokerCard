//
//  PokerContactView.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/25.
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

public enum PKContactOption {
    case email(_ address: String, _ symbol: UIImage? = nil)
    case message(_ icloud: String, _ symbol: UIImage? = nil)
    case wechat(_ id: String, _ symbol: UIImage? = nil)
    case weibo(_ name: URL, _ symbol: UIImage? = nil)
    case github(_ name: String, _ symbol: UIImage? = nil)
}

public class PokerContactView: PokerView {
    
    var contactOptions: [PKContactOption]? {
        didSet {
            let options = contactOptions
            options?.forEach { option in
                addContactOption(option)
            }
        }
    }
    
    private let titleLabel = UILabel()
    private var lastContact: PokerSubView?
    private let contactViewHeight: CGFloat = 52
    private let contactViewWidth: CGFloat = 225
    
    public init() {
        super.init(frame: CGRect.zero)
        
        frame.size.width = 265
        frame.size.height = 52
        
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        _ = layoutViews
    }
    
    private lazy var layoutViews: Void = {
        guard let superView = self.superview else {
            preconditionFailure("cannot get superview")
        }
        frame.origin.y = superView.frame.midY - frame.size.height / 2
    }()
    
    private func setupTitle() {
        titleLabel.text = "Contact Us"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        titleLabel.textColor = PKColor.label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func addContactOption(_ contact: PKContactOption) {
        let contactView = PokerSubView()
        addSubview(contactView)
        
        frame.size.height += 52 + 12
        
        contactView.heightAnchor.constraint(equalToConstant: contactViewHeight).isActive = true
        contactView.constraint(withLeadingTrailing: 20)
        contactView.topAnchor.constraint(equalTo: (lastContact ?? titleLabel).bottomAnchor, constant: 12).isActive = true
        lastContact = contactView
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contactView.addSubview(imageView)
        let detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contactView.addSubview(detailLabel)
        
        var isSymbolImage = false
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
            switch contact {
            case .email:
                isSymbolImage = true
                imageView.image = UIImage(systemName: "envelope", withConfiguration: config)
            case .message:
                isSymbolImage = true
                imageView.image = UIImage(systemName: "captions.bubble", withConfiguration: config)
            default: break
            }
            
            imageView.tintColor = PKColor.label
            imageView.leadingAnchor.constraint(equalTo: contactView.leadingAnchor, constant: isSymbolImage ? 16 : 22).isActive = true
            imageView.centerYAnchor.constraint(equalTo: contactView.centerYAnchor).isActive = true
            if !isSymbolImage {
                imageView.constraint(withWidthHeight: 32)
                imageView.contentMode = .scaleAspectFill
            }
            
        } else {
//            imageView =
        }
        
        switch contact {
        case .email: detailLabel.text = "Email"
        case .github: detailLabel.text = "GitHub"
        case .message: detailLabel.text = "iMessage"
        case .wechat: detailLabel.text = "WeChat"
        case .weibo: detailLabel.text = "Weibo"
        }
        detailLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        detailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: contactView.centerYAnchor).isActive = true
        
    }
    
}
