//
//  PokerAppearanceView.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/24.
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

fileprivate enum AppearanceSymbol: String {
    case light = "sun.max"
    case dark = "moon.fill"
    case auto = "circle.righthalf.fill"
}

public typealias PKAction = () -> Void
public class PokerAppearanceView: PokerView {
    
    var lightAppearanceView = PokerSubView()
    var darkAppearanceView = PokerSubView()
    var autoAppearanceView = PokerSubView()
    
    var lightTapped: PKAction = {
        if #available(iOS 13.0, *) {
            UserDefaults.standard.set(UIUserInterfaceStyle.light.rawValue, forKey: "userInterfaceStyle")
            currentWindow?.overrideUserInterfaceStyle = .light
        }
    }
    var darkTapped: PKAction = {
        if #available(iOS 13.0, *) {
            UserDefaults.standard.set(UIUserInterfaceStyle.dark.rawValue, forKey: "userInterfaceStyle")
            currentWindow?.overrideUserInterfaceStyle = .dark
        }
    }
    var autoTapped: PKAction = {
        if #available(iOS 13.0, *) {
            UserDefaults.standard.set(UIUserInterfaceStyle.unspecified.rawValue, forKey: "userInterfaceStyle")
            currentWindow?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        
        frame.size.width = 280
        frame.size.height = 162
        
        backgroundColor = PKColor.background
        
        setupAppearanceSelectionView()
    }
    
    @objc func hey() {
        print("hey")
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
    
    private func setupAppearanceSelectionView() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Appearance"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        titleLabel.textColor = PKColor.label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(lightAppearanceView)
        addSubview(darkAppearanceView)
        addSubview(autoAppearanceView)
        
        darkAppearanceView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        darkAppearanceView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        darkAppearanceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        darkAppearanceView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        lightAppearanceView.constraint(horizontalStack: darkAppearanceView)
        lightAppearanceView.trailingAnchor.constraint(equalTo: darkAppearanceView.leadingAnchor, constant: -15).isActive = true
        autoAppearanceView.constraint(horizontalStack: darkAppearanceView)
        autoAppearanceView.leadingAnchor.constraint(equalTo: darkAppearanceView.trailingAnchor, constant: 15).isActive = true
        
        lightAppearanceView.addElements(imgae: .light)
        darkAppearanceView.addElements(imgae: .dark)
        autoAppearanceView.addElements(imgae: .auto)
        
        let tapLight = UITapGestureRecognizer(target: self, action: #selector(appearanceSelected(_:)))
        let tapDark = UITapGestureRecognizer(target: self, action: #selector(appearanceSelected(_:)))
        let tapAuto = UITapGestureRecognizer(target: self, action: #selector(appearanceSelected(_:)))
        lightAppearanceView.addGestureRecognizer(tapLight)
        darkAppearanceView.addGestureRecognizer(tapDark)
        autoAppearanceView.addGestureRecognizer(tapAuto)
        
    }
    
    @objc func appearanceSelected(_ gesture: UITapGestureRecognizer) {
        guard let targetView = gesture.view else { return }
        if targetView === lightAppearanceView {
            print("light selected")
            lightTapped()
            if #available(iOS 10.0, *) {
                UISelectionFeedbackGenerator().selectionChanged()
            }
        } else if targetView === darkAppearanceView {
            print("dark selected")
            darkTapped()
            if #available(iOS 10.0, *) {
                UISelectionFeedbackGenerator().selectionChanged()
            }
        } else if targetView === autoAppearanceView {
            print("auto selected")
            autoTapped()
            if #available(iOS 10.0, *) {
                UISelectionFeedbackGenerator().selectionChanged()
            }
        }
    }
    
}

extension UIView {
    fileprivate func addElements(imgae symbolType: AppearanceSymbol) {
        var title = "Dark"
        switch symbolType {
        case .light: title = "Light"
        case .dark: title = "Dark"
        case .auto: title = "Auto"
        }
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
            let image = UIImage(systemName: symbolType.rawValue, withConfiguration: config)
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 20, weight: .light)
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
            label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            switch symbolType {
            case .light:
                imageView.tintColor = UIColor.black
                label.textColor = UIColor.black
                backgroundColor = PKColor.Appearance.light
            case .dark:
                imageView.tintColor = UIColor.white
                label.textColor = UIColor.white
                backgroundColor = PKColor.Appearance.dark
                
            case .auto:
                imageView.tintColor = PKColor.label
                label.textColor = PKColor.label
                backgroundColor = PKColor.Appearance.auto
            }
            
        } else {
            // Fallback on earlier versions
            let label = UILabel()
            label.text = title
            addSubview(label)
            label.center = center
            
            switch symbolType {
            case .light:
                label.textColor = UIColor.black
                backgroundColor = PKColor.Appearance.light
            case .dark:
                label.textColor = UIColor.white
                backgroundColor = PKColor.Appearance.dark
            case .auto:
                label.textColor = PKColor.label
                backgroundColor = PKColor.Appearance.auto
            }
        }
    }
}
