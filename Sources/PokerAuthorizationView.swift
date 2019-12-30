//
//  PokerAuthorizationView.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/12/21.
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

public enum PKAuthType {
    case bluetooth
    case camera
    case contacts
    case faceID
    case health
    case homeKit
    case location
    case microphone
    case music
    case notification
    case photoLibrary
}

internal class PokerAuthOptionView: PokerSubView {
    var authType: PKAuthType
    
    var infoLabel = PKLabel(fontSize: 20)
    var symbolImageView = UIImageView()
    
    init(type: PKAuthType) {
        self.authType = type
        super.init()
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(symbolImageView)
        addSubview(infoLabel)
        
        switch type {
        case .camera: infoLabel.text = "Use Camera"
        case .location: infoLabel.text = "Location Access"
        default:
            break
        }
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
            var symbolName = "camera"
            symbolImageView.image = UIImage(systemName: symbolName, withConfiguration: config)
            symbolImageView.tintColor = PKColor.label
            
        } else {
            symbolImageView.constraint(withWidthHeight: 30)
            symbolImageView.contentMode = .scaleAspectFit
        }
        
        symbolImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        symbolImageView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 36).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(authTapped(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc
    func authTapped(_ gesture: UITapGestureRecognizer) {
        switch authType {
        case .camera:
            UIView.animate(withDuration: 1) {
                self.layer.borderWidth = 1
                self.layer.borderColor = PKColor.pink.cgColor
            }
        case .location:
            UIView.animate(withDuration: 1) {
                self.layer.borderWidth = 1
                self.layer.borderColor = PKColor.blue.cgColor
            }
        default: break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class PokerAuthorizationView: PokerView, PokerTitleRepresentable {
    
    internal var authOptions: [PKAuthType]? {
        didSet {
            guard let options = authOptions, options.count <= 3 else {
                fatalError("You cannot apply for too many permissions at once.")
            }
            
            addAuthOption(options.first!)
        }
    }
    
    internal var titleLabel = PKLabel(fontSize: 20)
    internal var detailLabel: PKLabel?
    
    init() {
        super.init(frame: CGRect.zero)
        
        widthAnchor.constraint(equalToConstant: baseWidth).isActive = true
        titleLabel = setupTitleLabel(for: self, with: "")
        (titleLabel, detailLabel) = setupTitleDetailLabels(for: self, title: "Permission", detail: "This app requeires some authorizations. Please check them below.")
//        detailLabel?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAuthOption(_ option: PKAuthType) {
        let authView = PokerAuthOptionView(type: .camera)
        addSubview(authView)
        
        authView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        authView.constraint(withLeadingTrailing: 20)
        
        authView.topAnchor.constraint(equalTo: detailLabel!.bottomAnchor, constant: titleSpacing).isActive = true
        authView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
        
    }
}
