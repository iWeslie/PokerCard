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
@available (iOS 13.0, *)
internal enum AppearanceSymbol: String {
    case light = "sun.max"
    case dark = "moon.fill"
    case auto = "circle.righthalf.fill"
}

/// Poker Appearance selection view.
@available (iOS 13.0, *)
internal class PokerAppearanceSelectionView: PokerSubView {
    internal var titleLabel: PKLabel
    internal var symbolImage: UIImageView?
    
    fileprivate init(type: AppearanceSymbol) {
        let titleLabel = PKLabel(fontSize: 20)
        switch type {
        case .light: titleLabel.text = "Light"
        case .dark: titleLabel.text = "Dark"
        case .auto: titleLabel.text = "Auto"
        }
        self.titleLabel = titleLabel
        super.init()
        addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(pointSize: 30, name: type.rawValue))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        self.symbolImage = imageView
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        switch type {
        case .light:
            imageView.tintColor = UIColor.black
            titleLabel.textColor = UIColor.black
            backgroundColor = PKColor.Appearance.light
        case .dark:
            imageView.tintColor = UIColor.white
            titleLabel.textColor = UIColor.white
            backgroundColor = PKColor.Appearance.dark
        case .auto:
            imageView.tintColor = PKColor.label
            titleLabel.textColor = PKColor.label
            backgroundColor = PKColor.Appearance.auto
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Poker Appearance single option view.
@available (iOS 13.0, *)
class PokerAppearanceOptionView: PKContainerView {
    
    internal var titleLabel = PKLabel(fontSize: 19)
    internal var optionTrigger: PKTrigger?
    
    private var circleImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(pointSize: 25, name: "circle"))
        imageView.tintColor = PKColor.label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var checkmarkButton: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.tintColor = PKColor.label
        button.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        let image = UIImage(systemName: "checkmark", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        return button
    }()

    init(title: String?, isChecked: Bool) {
        super.init()
        addSubview(checkmarkButton)
        titleLabel.text = title
        setupConstraints()
        checkmarkButton.isChecked = isChecked
        checkmarkButton.addTarget(self, action: #selector(triggered(_:)), for: .touchUpInside)
        checkmarkButton.imageView?.tintColor = isChecked ? PKColor.label : PKColor.clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    @objc
    private func triggered(_ sender: UIButton) {
        UISelectionFeedbackGenerator().selectionChanged()
        if sender.isChecked {
            // uncheck
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
                sender.imageView?.tintColor = PKColor.clear
                sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 5))
            }, completion: nil)
        } else {
            // check
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                sender.imageView?.tintColor = PKColor.label
                sender.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
        print(sender.isChecked)
        sender.isChecked = !sender.isChecked
        optionTrigger?(sender.isChecked)
    }
}

/// Poker View for appearance selection
@available (iOS 13.0, *)
public class PokerAppearanceView: PokerView, PokerTitleRepresentable {
    
    internal var titleLabel = PKLabel(fontSize: 20)
    internal var lightAppearanceView = PokerAppearanceSelectionView(type: .light)
    internal var darkAppearanceView = PokerAppearanceSelectionView(type: .dark)
    internal var autoAppearanceView = PokerAppearanceSelectionView(type: .auto)
    
    internal var lightTapped: PKAction?
    internal var darkTapped: PKAction?
    internal var autoTapped: PKAction?
    
    private var optionView: PokerAppearanceOptionView?
    
    var optionTrigger: PKTrigger?
    var isChecked = false
    var optionTitle: String? {
        didSet {
            let optionView = PokerAppearanceOptionView(title: optionTitle, isChecked: isChecked)
            optionView.optionTrigger = optionTrigger
            
            addSubview(optionView)
            optionView.constraint(withLeadingTrailing: titleSpacing)
            optionView.topAnchor.constraint(equalTo: darkAppearanceView.bottomAnchor, constant: 20).isActive = true
            optionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
            
            self.optionView = optionView
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        widthAnchor.constraint(equalToConstant: 280).isActive = true
        setupAppearanceSelectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearanceSelectionView() {
        titleLabel = setupTitleLabel(for: self, with: "Appearance")
        
        let selectionViews = [lightAppearanceView, darkAppearanceView, autoAppearanceView]
        selectionViews.forEach(addSubview(_:))
        
        darkAppearanceView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        darkAppearanceView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        darkAppearanceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleSpacing).isActive = true
        darkAppearanceView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let darkAppearanceViewBCons = darkAppearanceView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing)
        darkAppearanceViewBCons.isActive = true
        darkAppearanceViewBCons.priority = .defaultHigh
        
        lightAppearanceView.constraint(horizontalStack: darkAppearanceView)
        lightAppearanceView.trailingAnchor.constraint(equalTo: darkAppearanceView.leadingAnchor, constant: -titleSpacing).isActive = true
        autoAppearanceView.constraint(horizontalStack: darkAppearanceView)
        autoAppearanceView.leadingAnchor.constraint(equalTo: darkAppearanceView.trailingAnchor, constant: titleSpacing).isActive = true
        
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
        UISelectionFeedbackGenerator().selectionChanged()
        if targetView === lightAppearanceView {
            lightTapped?()
            UserDefaults.standard.set(UIUserInterfaceStyle.light.rawValue, forKey: "userInterfaceStyle")
            currentWindow?.overrideUserInterfaceStyle = .light
        } else if targetView === darkAppearanceView {
            darkTapped?()
            UserDefaults.standard.set(UIUserInterfaceStyle.dark.rawValue, forKey: "userInterfaceStyle")
            currentWindow?.overrideUserInterfaceStyle = .dark
        } else if targetView === autoAppearanceView {
            autoTapped?()
            UserDefaults.standard.set(UIUserInterfaceStyle.unspecified.rawValue, forKey: "userInterfaceStyle")
            currentWindow?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
