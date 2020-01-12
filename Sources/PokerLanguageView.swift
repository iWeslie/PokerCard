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

internal protocol PKLanguageSelectionDelegate: class {
    func didSelect(_ languageOptionView: PokerLanguageOptionView, with language: PKLangType)
}

internal class PokerLanguageOptionView: PokerOptionView {
    
    var languageType: PKLangType
    
    weak var delegate: PKLanguageSelectionDelegate?
    
    init(langOption: PKOption.Language) {
        let langType = langOption.type
        self.languageType = langType
        super.init(option: langOption)
        
        switch langType {
        case .en: titleLabel.text = "English"
        case .zh: titleLabel.text = "简体中文"
        case .auto: titleLabel.text = "Follow System"
        }
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
            var symbolName = "arrow.2.circlepath"
            switch langType {
            case .en: symbolName = "textformat"
            case .zh: symbolName = "globe"
            case .auto: symbolName = "arrow.2.circlepath"
            }
            imageView.image = UIImage(systemName: symbolName, withConfiguration: config)
            imageView.tintColor = PKColor.label
            
            let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
            checkmarkImageView.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
            checkmarkImageView.tintColor = PKColor.label
        } else {
            imageView.constraint(withWidthHeight: 30)
            imageView.contentMode = .scaleAspectFit
        }
        
        checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(languageSelected(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc
    func languageSelected(_ gesture: UITapGestureRecognizer) {
        delegate?.didSelect(self, with: languageType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class PokerLanguageView: PokerView, PokerTitleRepresentable {
    
    static var isAutoLanguageType = true
    
    internal var titleLabel = PKLabel(fontSize: 20)
    private var allLangViews: [PokerLanguageOptionView] = [] {
        didSet {
            
        }
    }
    private var lastLangView: PokerSubView?
    
    internal var langOptions: [PKOption.Language]? {
        didSet {
            langOptions?.forEach { addLangOptionView(with: $0) }
            lastLangView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
            
            var langType: PKLangType = .auto
            if let langArray = UserDefaults.standard.array(forKey: appleLanguageKey) as? [String],
                !PokerLanguageView.isAutoLanguageType,
                langArray.count == 1,
                let type = PKLangType(rawValue: langArray.first!)
            {
                langType = type
            }
            
            allLangViews.forEach { langView in
                langView.delegate = self
                langView.heightAnchor.constraint(equalToConstant: 52).isActive = true
                langView.constraint(withLeadingTrailing: 20)
                
                langView.checkmarkImageView.isHidden = true
                if langView.languageType == langType {
                    langView.checkmarkImageView.isHidden = false
                }
            }
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        
        titleLabel = setupTitleLabel(for: self, with: "Language")
        
        widthAnchor.constraint(equalToConstant: baseWidth).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLangOptionView(with langOption: PKOption.Language) {
        let langView = PokerLanguageOptionView(langOption: langOption)
        langView.titleLabel.text = langOption.title
        langView.imageView.image = langOption.image
        addSubview(langView)
        
        langView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        langView.constraint(withLeadingTrailing: 20)
        langView.topAnchor.constraint(equalTo: (lastLangView ?? titleLabel).bottomAnchor, constant: internalSpacing).isActive = true
        lastLangView = langView
        
        allLangViews.append(langView)
    }
    
}

extension PokerLanguageView: PKLanguageSelectionDelegate {
    internal func didSelect(_ languageOptionView: PokerLanguageOptionView, with language: PKLangType) {
        
        UISelectionFeedbackGenerator().selectionChanged()
        allLangViews.forEach { langView in
            langView.checkmarkImageView.isHidden = true
        }
        languageOptionView.checkmarkImageView.isHidden = false
        
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
