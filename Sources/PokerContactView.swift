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
    case email(_ entity: MailEntity)
    case message(_ entity: MessageEntity)
    case wechat(_ id: String)
    case weibo(_ weiboUID: String)
    case github(_ id: String)
    case other(_ url: URL)
    
    /// This class is an mediator for mail composing.
    /// To get detailed information, see documetation for `MFMailComposeViewController`.
    public class MailEntity {
        /// A string specifying the message's Subject header.
        public var subject: String?
        /// A string array instances specifying the email addresses of recipients.
        public var toRecipients: [String]?
        /// A string array instances specifying the email addresses of recipients.
        public var ccRecipients: [String]?
        /// A string array instances specifying the email addresses of recipients.
        public var bccRecipients: [String]?
        /// A string containing the body contents of the email message.
        public var body: String?
        /// A boolean value indicating if the body argument is to be interpreted as HTML content. `False` by default.
        public var isBodyHTML: Bool = false
        
        /// A closure that you can customize your `MFMailComposeViewController`.
        ///
        /// You can access all methods and properties of through this configuration.
        public var configuration: ((MFMailComposeViewController) -> Void)?
        
        internal var attachment: Data?
        internal var mimeType: String!
        internal var filename: String!
        internal var preferredSendingEmailAddress: String?
        
        public init() {}
        
        /// This method sets the body of the email message to the specified content.
        ///
        /// To get detailed information, see documetation for `MFMailComposeViewController`.
        ///
        /// - Parameters:
        ///   - body:   A string containing the body contents of the email message.
        ///   - isHTML: A boolean value indicating if the body argument is to be interpreted as HTML content.
        public func setMessageBody(_ body: String, isHTML: Bool) {
            self.body = body
            self.isBodyHTML = isHTML
        }
        
        /// This method adds the specified attachment to the email message.
        ///
        /// To get detailed information, see documetation for `MFMailComposeViewController`.
        ///
        /// - Parameters:
        ///   - attachment: The Data containing the contents of the attachment.
        ///   - mimeType:   A String specifying the MIME type for the attachment.
        ///   - filename:   A String specifying the intended filename for the attachment.
        public func addAttachmentData(_ attachment: Data, mimeType: String, fileName filename: String) {
            self.attachment = attachment
            self.mimeType = mimeType
            self.filename = filename
        }
        
        /// This method sets the preferred sending account of the email message.
        ///
        /// To get detailed information, see documetation for `MFMailComposeViewController`.
        ///
        /// - Parameter emailAddress: A string specifying the preferred email address used to send this message.
        @available(iOS 11.0, *)
        public func setPreferredSendingEmailAddress(_ emailAddress: String) {
            self.preferredSendingEmailAddress = emailAddress
        }
    }
    
    /// This class is an mediator for mail composing.
    /// To get detailed information, see documetation for `MFMessageComposeViewController`.
    public class MessageEntity {
        /// This property sets the initial value of the To field for the message to the specified addresses.
        public var recipients: [String]?
        /// This property sets the initial value of the body of the message to the specified content.
        public var body: String?
        /// This property sets the initial value of the subject of the message to the specified content.
        public var subject: String?
        
        /// A closure that you can customize your `MFMessageComposeViewController`.
        ///
        /// You can access all methods and properties of through this configuration.
        public var configuration: ((MFMessageComposeViewController) -> Void)?
        
        public init() {}
    }
}

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
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

/// Poker View for contact options
public class PokerContactView: PokerView, PokerTitleRepresentable {
    
    internal var targetController: UIViewController?
    internal var contactOptions: [PKOption.Contact]? {
        didSet {
            let options = contactOptions
            options?.forEach { option in
                addContactOptionView(with: option)
            }
            lastContact?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
        }
    }
    
    internal var titleLabel = PKLabel(fontSize: 20)
    private var lastContact: PokerSubView?
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
        contactView.titileLabel.text = contactOption.title
        contactView.imageView.image = contactOption.image
        addSubview(contactView)
        
        contactView.heightAnchor.constraint(equalToConstant: contactViewHeight).isActive = true
        contactView.constraint(withLeadingTrailing: 20)
        contactView.topAnchor.constraint(equalTo: (lastContact ?? titleLabel).bottomAnchor, constant: internalSpacing).isActive = true
        lastContact = contactView
        
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
