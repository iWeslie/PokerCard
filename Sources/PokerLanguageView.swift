//
//  PokerLanguageView.swift
//  PokerCard
//
//  Created by Weslie on 2019/9/27.
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

let appleLanguageKey = "AppleLanguages"

internal protocol PKLanguageSelectionDelegate: class {
    func didSelect(_ languageOptionView: PokerLanguageOptionView, with language: LangType)
}

internal class PokerLanguageOptionView: PokerSubView {
    
    var languageType: LangType = .auto
    
    weak var delegate: PKLanguageSelectionDelegate?
    
    fileprivate var infoLabel = PKLabel(fontSize: 20)
    internal var symbolImageView = UIImageView()
    internal var checkmarkImageView = UIImageView()
    
    init(type: LangType) {
        super.init()
        self.languageType = type
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.isHidden = false
        [infoLabel, symbolImageView, checkmarkImageView].forEach(addSubview(_:))
        
        switch type {
        case .en: infoLabel.text = "English"
        case .zh: infoLabel.text = "简体中文"
        case .auto: infoLabel.text = "Follow System"
        }
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
            var symbolName = "arrow.2.circlepath"
            switch type {
            case .en: symbolName = "textformat"
            case .zh: symbolName = "globe"
            case .auto: symbolName = "arrow.2.circlepath"
            }
            symbolImageView.image = UIImage(systemName: symbolName, withConfiguration: config)
            symbolImageView.tintColor = PKColor.label
            
            let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
            checkmarkImageView.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
            checkmarkImageView.tintColor = PKColor.label
        } else {
            symbolImageView.constraint(withWidthHeight: 30)
            symbolImageView.contentMode = .scaleAspectFit
        }
        
        symbolImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        symbolImageView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 36).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64).isActive = true
        checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(languageSelected(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc
    func languageSelected(_ gesture: UITapGestureRecognizer) {
        switch languageType {
        case .en: delegate?.didSelect(self, with: .en)
        case .zh: delegate?.didSelect(self, with: .zh)
        case .auto: delegate?.didSelect(self, with: .auto)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class PokerLanguageView: PokerView, PokerTitleRepresentable {
    
    static var isAutoLanguageType = true
    
    var enTapped: PKAction?
    var zhTapped: PKAction?
    var autoTapped: PKAction?
    
    internal var titleLabel = PKLabel(fontSize: 20)
    internal var enLangView = PokerLanguageOptionView(type: .en)
    internal var zhLangView = PokerLanguageOptionView(type: .zh)
    internal var autoLangView = PokerLanguageOptionView(type: .auto)
    
    init() {
        super.init(frame: CGRect.zero)
        
        widthAnchor.constraint(equalToConstant: baseWidth).isActive = true
        titleLabel = setupTitleLabel(for: self, with: "Language")
        
        var langType: LangType = .auto
        if let langArray = UserDefaults.standard.array(forKey: appleLanguageKey) as? [String],
            !PokerLanguageView.isAutoLanguageType,
            langArray.count == 1,
            let type = LangType(rawValue: langArray.first!)
        {
            langType = type
        }
        
        [enLangView, zhLangView, autoLangView].forEach { langView in
            addSubview(langView)
            langView.delegate = self
            langView.heightAnchor.constraint(equalToConstant: 52).isActive = true
            langView.constraint(withLeadingTrailing: 20)
            
            langView.checkmarkImageView.isHidden = true
            if langView.languageType == langType {
                langView.checkmarkImageView.isHidden = false
            }
        }
        
        enLangView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleSpacing).isActive = true
        zhLangView.topAnchor.constraint(equalTo: enLangView.bottomAnchor, constant: internalSpacing).isActive = true
        autoLangView.topAnchor.constraint(equalTo: zhLangView.bottomAnchor, constant: internalSpacing).isActive = true
        autoLangView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokerLanguageView: PKLanguageSelectionDelegate {
    internal func didSelect(_ languageOptionView: PokerLanguageOptionView, with language: LangType) {
        
        UISelectionFeedbackGenerator().selectionChanged()
        [enLangView, zhLangView, autoLangView].forEach { langView in
            langView.checkmarkImageView.isHidden = true
        }
        languageOptionView.checkmarkImageView.isHidden = false
        
        switch language {
        case .en: enTapped?()
        case .zh: zhTapped?()
        case .auto: autoTapped?()
        }
        if language == .auto {
            UserDefaults.standard.set(nil, forKey: appleLanguageKey)
            PokerLanguageView.isAutoLanguageType = true
        } else {
            UserDefaults.standard.set([language.rawValue], forKey: appleLanguageKey)
            PokerLanguageView.isAutoLanguageType = false
        }
        UserDefaults.standard.synchronize()
    }
}
