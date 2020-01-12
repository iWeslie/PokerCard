//
//  PKTypes.swift
//  PokerCard
//
//  Created by Weslie Chen on 2020/1/8.
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

import MessageUI

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

/// User Defaults key for app language configuration
public let appleLanguageKey = "AppleLanguages"

public enum PKLangType: String {
    case en = "en"
    case zh = "zh-Hans"
    case auto
}

public enum PKAuthType: String {
//    case bluetooth = ""
    case camera = "camera"
    case contacts = "person.crop.circle"
    case faceID = "faceid"
    case health = "heart"
    case homeKit = "house"
    case location = "location"
    case microphone = "mic"
    case music = "music.note.list"
    case notification = "ellipses.bubble"
    case photoLibrary = "photo.fill"
}
