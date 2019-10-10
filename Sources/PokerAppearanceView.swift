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

/// Call this method in AppDelegate's `didFinishLaunchingWithOptions` to override global interface style.
public func overrideUserInterfacrStyle() {
    if #available(iOS 13.0, *) {
        let interfaceStyle = UIUserInterfaceStyle(rawValue: UserDefaults.standard.integer(forKey: "userInterfaceStyle")) ?? .unspecified
        currentWindow?.overrideUserInterfaceStyle = interfaceStyle
    }
}

/// Poker Appearance symbol image name enums.
fileprivate enum AppearanceSymbol: String {
    case light = "sun.max"
    case dark = "moon.fill"
    case auto = "circle.righthalf.fill"
}

class PokerAppearanceOptionView: PKContainerView {
    
    var titleLabel = PKLabel(fontSize: 19)
    
    var circleImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(pointSize: 25, name: "circle"))
        imageView.tintColor = PKColor.label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.tintColor = PKColor.label
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
            let image = UIImage(systemName: "checkmark", withConfiguration: configuration)
            button.setImage(image, for: .normal)
        }
        return button
    }()

    var optionTrigger: PKTrigger?
    
    init(title: String?, isChecked: Bool) {
        super.init()
        titleLabel.text = title
        setupConstraints()
        
        checkmarkButton.addTarget(self, action: #selector(triggered(_:)), for: .touchUpInside)
        checkmarkButton.imageView?.tintColor = isChecked ? PKColor.label : PKColor.clear
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.constraint(withTopBottom: 2)
        
        insertSubview(circleImage, belowSubview: checkmarkButton)
        circleImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        circleImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        checkmarkButton.centerXAnchor.constraint(equalTo: circleImage.centerXAnchor).isActive = true
        checkmarkButton.centerYAnchor.constraint(equalTo: circleImage.centerYAnchor, constant: 1).isActive = true
    }
    
    @objc func triggered(_ sender: UIButton) {
        optionTrigger?(sender.isChecked)
        sender.isChecked = !sender.isChecked
        
        triggerSelectionChangedHapticFeedback()
        if sender.isChecked {
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
                sender.imageView?.tintColor = PKColor.clear
                sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 5))
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                sender.imageView?.tintColor = PKColor.label
                sender.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Poker View for appearance selection
public class PokerAppearanceView: PokerView {
    
    internal var lightAppearanceView = PokerSubView()
    internal var darkAppearanceView = PokerSubView()
    internal var autoAppearanceView = PokerSubView()
    
    internal var lightTapped: PKAction?
    internal var darkTapped: PKAction?
    internal var autoTapped: PKAction?
    
    internal var optionView: PokerAppearanceOptionView?
    
    var optionTrigger: PKTrigger?
    var isChecked = false
    var optionTitle: String? {
        didSet {
            let optionView = PokerAppearanceOptionView(title: optionTitle, isChecked: isChecked)
            optionView.optionTrigger = optionTrigger
            
            frame.size.height += 40
            addSubview(optionView)
            optionView.constraint(withLeadingTrailing: 16)
            optionView.topAnchor.constraint(equalTo: darkAppearanceView.bottomAnchor, constant: 20).isActive = true
            
            self.optionView = optionView
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        
        frame.size.width = 280
        frame.size.height = 162
        
        setupAppearanceSelectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearanceSelectionView() {
        let titleLabel = PKLabel(fontSize: 20)
        titleLabel.text = "Appearance"
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
    
    @objc
    private func appearanceSelected(_ gesture: UITapGestureRecognizer) {
        guard let targetView = gesture.view else { return }
        triggerSelectionChangedHapticFeedback()
        if targetView === lightAppearanceView {
            lightTapped?()
            if #available(iOS 13.0, *) {
                UserDefaults.standard.set(UIUserInterfaceStyle.light.rawValue, forKey: "userInterfaceStyle")
                currentWindow?.overrideUserInterfaceStyle = .light
            }
        } else if targetView === darkAppearanceView {
            darkTapped?()
            if #available(iOS 13.0, *) {
                UserDefaults.standard.set(UIUserInterfaceStyle.dark.rawValue, forKey: "userInterfaceStyle")
                currentWindow?.overrideUserInterfaceStyle = .dark
            }
        } else if targetView === autoAppearanceView {
            autoTapped?()
            if #available(iOS 13.0, *) {
                UserDefaults.standard.set(UIUserInterfaceStyle.unspecified.rawValue, forKey: "userInterfaceStyle")
                currentWindow?.overrideUserInterfaceStyle = .unspecified
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
