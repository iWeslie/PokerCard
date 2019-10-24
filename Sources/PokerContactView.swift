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
import MessageUI
import SafariServices

public enum PKContactType {
    case email(_ recipients: [String])
    case message(_ recipients: [String])
    case wechat(_ id: String)
    case weibo(_ weiboUID: String)
    case github(_ name: String)
    case other(_ url: URL)
}

/// Contact options enum
public class PKContactOption {
    
    fileprivate var contactKey: String?
    fileprivate var image: UIImage?
    fileprivate var title: String
    
    public var delay: TimeInterval = 0
    public var completion: PKAction?
    
    fileprivate var type: PKContactType
    fileprivate var recipients: [String]?
    
    public init(type: PKContactType, image: UIImage?, title: String) {
        switch type {
        case .email(let recipients): self.recipients = recipients
        case .github(let name): self.contactKey = name
        case .message(let recipients): self.recipients = recipients
        case .wechat(let id): self.contactKey = id
        case .weibo(let weiboURL): self.contactKey = weiboURL
        default: break
        }
        self.image = image
        self.title = title
        self.type = type
    }
    
}

fileprivate class PokerContactOptionView: PokerSubView {
    
    var option: PKContactOption
    fileprivate var isSymbolImage = false
    fileprivate var imageView = UIImageView()
    fileprivate var detailLabel = PKLabel(fontSize: 20)
    
    init(option: PKContactOption) {
        self.option = option
        super.init()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(detailLabel)
        
        detailLabel.text = option.title
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
            switch option.type {
            case .email:
                isSymbolImage = true
                imageView.image = UIImage(systemName: "envelope", withConfiguration: config)
            case .message:
                isSymbolImage = true
                imageView.image = UIImage(systemName: "captions.bubble", withConfiguration: config)
            default:
                isSymbolImage = false
                imageView.image = option.image
            }
            imageView.tintColor = PKColor.label
            if !isSymbolImage {
                imageView.constraint(withWidthHeight: 32)
                imageView.contentMode = .scaleAspectFill
            }
        } else {
            imageView.constraint(withWidthHeight: 32)
            imageView.contentMode = .scaleAspectFit
            imageView.image = option.image
        }
        
        imageView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 36).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Poker View for contact options
public class PokerContactView: PokerView, PokerTitleRepresentable {
    
    internal var targetController: UIViewController?
    internal var contactOptions: [PKContactOption]? {
        didSet {
            let options = contactOptions
            options?.forEach { option in
                addContactOption(option)
            }
            lastContact?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        }
    }
    
    internal var titleLabel = PKLabel(fontSize: 20)
    private var lastContact: PokerSubView?
    private let contactViewHeight: CGFloat = 52
    private let contactViewWidth: CGFloat = 225
    
    public init() {
        super.init(frame: CGRect.zero)
        
        titleLabel = setupTitleLabel(for: self, with: "Contact Us")
        
        let titleBCons = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        titleBCons.priority = .defaultLow
        titleBCons.isActive = true
        widthAnchor.constraint(equalToConstant: 265).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContactOption(_ contactOption: PKContactOption) {
        let contactView = PokerContactOptionView(option: contactOption)
        addSubview(contactView)
        
        contactView.heightAnchor.constraint(equalToConstant: contactViewHeight).isActive = true
        contactView.constraint(withLeadingTrailing: 20)
        contactView.topAnchor.constraint(equalTo: (lastContact ?? titleLabel).bottomAnchor, constant: 12).isActive = true
        lastContact = contactView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(contactViewTapped(_:)))
        contactView.addGestureRecognizer(tap)
        
    }
    
    @objc
    func contactViewTapped(_ gesture: UITapGestureRecognizer) {
        guard let contactOptionView = gesture.view as? PokerContactOptionView else { return }
        let delay = contactOptionView.option.delay
        let completion = contactOptionView.option.completion
        
        switch contactOptionView.option.type {
        case .email(let recipients): composeMail(to: recipients, afterDelay: delay, completion: completion)
        case .message(let recipients): composeMessage(to: recipients, afterDelay: delay, completion: completion)
        case .github(let name): presentGitHubWebPage(with: name, afterDelay: delay, completion: completion)
        case .wechat(let id): jumpToWeChat(withID: id, afterDelay: delay, completion: completion)
        case .weibo(let weiboUID): jumpToWeibo(withID: weiboUID, afterDelay: delay, completion: completion)
        case .other: break
        }
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    private func composeMail(to recipients: [String], afterDelay interval: TimeInterval, completion: PKAction?) {
        guard MFMailComposeViewController.canSendMail() else {
            debugPrint("You can not sent email on simulator. Please do it on a device.")
            return
        }
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = targetController as? MFMailComposeViewControllerDelegate
        mailViewController.setToRecipients(recipients)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.targetController?.present(mailViewController, animated: true, completion: completion)
        }
    }
    
    private func composeMessage(to recipients: [String], afterDelay interval: TimeInterval, completion: PKAction?) {
        guard MFMessageComposeViewController.canSendText() else {
            debugPrint("You can not sent message on simulator. Please do it on a device.")
            return
        }
        let messageViewController = MFMessageComposeViewController()
        messageViewController.messageComposeDelegate = targetController as? MFMessageComposeViewControllerDelegate
        messageViewController.recipients = recipients
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.targetController?.present(messageViewController, animated: true, completion: completion)
        }
    }
    
    private func jumpToWeChat(withID wechatID: String, afterDelay interval: TimeInterval, completion: PKAction?) {
        let url = URL(string: "weixin://\(wechatID)")!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            UIApplication.shared.open(url, options: [:]) { _ in
                completion?()
            }
        }
    }
    
    private func jumpToWeibo(withID weiboUID: String, afterDelay interval: TimeInterval, completion: PKAction?) {
        let weiboURL = URL(string: "sinaweibo://userinfo?uid=\(weiboUID)")!
        let weiboIURL = URL(string: "weibointernational://userinfo?uid=\(weiboUID)")!
        
        if UIApplication.shared.canOpenURL(weiboURL) {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                UIApplication.shared.open(weiboURL, options: [:]) { _ in
                    completion?()
                }
            }
        } else if UIApplication.shared.canOpenURL(weiboIURL) {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                UIApplication.shared.open(weiboIURL, options: [:]) { _ in
                    completion?()
                }
            }
        } else {
            debugPrint("Weibo not installed.")
        }
    }
    
    private func presentGitHubWebPage(with name: String, afterDelay interval: TimeInterval, completion: PKAction?) {
        let safariController = SFSafariViewController(url: URL(string: "https://github.com/\(name)")!)
        safariController.modalPresentationStyle = .popover
        targetController?.present(safariController, animated: true, completion: nil)
    }
    
}
