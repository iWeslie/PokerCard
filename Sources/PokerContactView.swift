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

//fileprivate class PokerContactOptionView: PokerOptionView {
//
//    fileprivate let option: PKContactOption
//    fileprivate var isSymbolImage = false
//
//    init(option: PKContactOption) {
//        self.option = option
//        super.init()

//        if #available(iOS 13.0, *) {
//            let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
//            switch option.type {
//            case .email:
//                isSymbolImage = true
//                imageView.image = UIImage(systemName: "envelope", withConfiguration: config)
//            case .message:
//                isSymbolImage = true
//                imageView.image = UIImage(systemName: "captions.bubble", withConfiguration: config)
//            default:
//                isSymbolImage = false
//                imageView.image = option.image
//            }
//            imageView.tintColor = PKColor.label
//            if !isSymbolImage {
//                imageView.constraint(withWidthHeight: 32)
//                imageView.contentMode = .scaleAspectFill
//            }
//        } else {
//            imageView.constraint(withWidthHeight: 32)
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = option.image
//        }
//
//    }

/// Poker View for contact options
public class PokerContactView: PokerView, PokerTitleRepresentable {
    
    internal var targetController: UIViewController?
    internal var contactOptions: [PKOption.Contact]? {
        didSet {
            contactOptions?.forEach { addContactOptionView(with: $0) }
            lastContactView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
        }
    }
    
    internal var titleLabel = PKLabel(fontSize: 20)
    private var lastContactView: PokerSubView?
    private let contactViewHeight: CGFloat = 52
    private let contactViewWidth: CGFloat = 225
    
    public init() {
        super.init(frame: CGRect.zero)
        
        titleLabel = setupTitleLabel(for: self, with: "Contact Us")
        
        let titleBCons = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing)
        titleBCons.priority = .defaultLow
        titleBCons.isActive = true
        widthAnchor.constraint(equalToConstant: baseWidth).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContactOptionView(with contactOption: PKOption.Contact) {
        let contactView = PokerOptionView(option: contactOption)
        contactView.titleLabel.text = contactOption.title
        contactView.imageView.image = contactOption.image
        addSubview(contactView)
        
        contactView.heightAnchor.constraint(equalToConstant: contactViewHeight).isActive = true
        contactView.constraint(withLeadingTrailing: 20)
        contactView.topAnchor.constraint(equalTo: (lastContactView ?? titleLabel).bottomAnchor, constant: internalSpacing).isActive = true
        lastContactView = contactView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(contactViewTapped(_:)))
        contactView.addGestureRecognizer(tap)
        
    }
    
    @objc
    private func contactViewTapped(_ gesture: UITapGestureRecognizer) {
        guard let contactOptionView = gesture.view as? PokerOptionView else { return }
        let option = contactOptionView.option
        
        guard let contactType = (contactOptionView.option as? PKOption.Contact)?.type else {
            fatalError("PokerContactView can only hold Contact Options.")
        }
        
        switch contactType {
        case .email(let mailEntity): composeMail(with: mailEntity, on: option)
        case .message(let messageEntity): composeMessage(with: messageEntity, on: option)
        case .github(let name): presentGitHubWebPage(with: name, on: option)
        case .wechat(let id): jumpToWeChat(withID: id, on: option)
        case .weibo(let weiboUID): jumpToWeibo(withID: weiboUID, on: option)
        case .other: break
        }
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    // MARK: - Aidded methods
    private func composeMail(with entity: PKContactType.MailEntity, on option: PokerOptionBaseElements) {
        guard MFMailComposeViewController.canSendMail() else {
            debugPrint("You can not sent email on simulator. Please do it on a device.")
            return
        }
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = targetController as? MFMailComposeViewControllerDelegate
        
        mailViewController.setToRecipients(entity.toRecipients)
        mailViewController.setCcRecipients(entity.ccRecipients)
        mailViewController.setBccRecipients(entity.bccRecipients)
        if let subject = entity.subject {
            mailViewController.setSubject(subject)
        }
        if let body = entity.body {
            mailViewController.setMessageBody(body, isHTML: entity.isBodyHTML)
        }
        if #available(iOS 11.0, *), let preferredAddress = entity.preferredSendingEmailAddress {
            mailViewController.setPreferredSendingEmailAddress(preferredAddress)
        }
        if let attachment = entity.attachment {
            mailViewController.addAttachmentData(attachment, mimeType: entity.mimeType, fileName: entity.filename)
        }
        
        entity.configuration?(mailViewController)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + option.delay) {
            self.targetController?.present(mailViewController, animated: true, completion: option.action)
        }
    }
    
    private func composeMessage(with entity: PKContactType.MessageEntity, on option: PokerOptionBaseElements) {
        guard MFMessageComposeViewController.canSendText() else {
            debugPrint("You can not sent message on simulator. Please do it on a device.")
            return
        }
        let messageViewController = MFMessageComposeViewController()
        messageViewController.messageComposeDelegate = targetController as? MFMessageComposeViewControllerDelegate
        messageViewController.recipients = entity.recipients
        messageViewController.body = entity.body
        messageViewController.subject = entity.subject
        
        entity.configuration?(messageViewController)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + option.delay) {
            self.targetController?.present(messageViewController, animated: true, completion: option.action)
        }
    }
    
    private func jumpToWeChat(withID wechatID: String, on option: PokerOptionBaseElements) {
        let url = URL(string: "weixin://\(wechatID)")!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + option.delay) {
            UIApplication.shared.open(url, options: [:]) { _ in
                option.action?()
            }
        }
    }
    
    private func jumpToWeibo(withID weiboUID: String, on option: PokerOptionBaseElements) {
        let weiboURL = URL(string: "sinaweibo://userinfo?uid=\(weiboUID)")!
        let weiboIURL = URL(string: "weibointernational://userinfo?uid=\(weiboUID)")!
        
        if UIApplication.shared.canOpenURL(weiboURL) {
            DispatchQueue.main.asyncAfter(deadline: .now() + option.delay) {
                UIApplication.shared.open(weiboURL, options: [:]) { _ in
                    option.action?()
                }
            }
        } else if UIApplication.shared.canOpenURL(weiboIURL) {
            DispatchQueue.main.asyncAfter(deadline: .now() + option.delay) {
                UIApplication.shared.open(weiboIURL, options: [:]) { _ in
                    option.action?()
                }
            }
        } else {
            debugPrint("Weibo not installed.")
        }
    }
    
    private func presentGitHubWebPage(with name: String, on option: PokerOptionBaseElements) {
        let safariController = SFSafariViewController(url: URL(string: "https://github.com/\(name)")!)
        safariController.modalPresentationStyle = .popover
        targetController?.present(safariController, animated: true, completion: nil)
    }
    
}
