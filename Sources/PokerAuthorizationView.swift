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
import UserNotifications
import CoreLocation

//        if #available(iOS 13.0, *) {
//            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
//            let symbolName = "camera"
//            imageView.image = UIImage(systemName: symbolName, withConfiguration: config)
//            imageView.tintColor = PKColor.label
//
//        } else {
//            imageView.constraint(withWidthHeight: 30)
//            imageView.contentMode = .scaleAspectFit
//        }
    
//    @objc
//    func authTapped(_ gesture: UITapGestureRecognizer) {
//        switch authType {
//        case .camera:
//            UIView.animate(withDuration: 1) {
//                self.layer.borderWidth = 1
//                self.layer.borderColor = PKColor.pink.cgColor
//            }
//        case .location:
//            UIView.animate(withDuration: 1) {
//                self.layer.borderWidth = 1
//                self.layer.borderColor = PKColor.blue.cgColor
//            }
//        default: break
//        }
//    }

public class PokerAuthorizationView: PokerView, PokerTitleRepresentable {
    
    internal var authOptions: [PKOption.Auth]? {
        didSet {
            guard let options = authOptions, options.count <= 3 else {
                fatalError("You cannot apply for too many permissions at once.")
            }
            
            options.forEach { addAuthOption(with: $0) }
            lastAuthView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titleSpacing).isActive = true
        }
    }
    
    internal var titleLabel = PKLabel(fontSize: 20)
    internal var detailLabel: PKLabel?
    
    private var lastAuthView: PokerSubView?
    
    private lazy var locationManager = CLLocationManager()
    
    public init() {
        super.init(frame: CGRect.zero)
        
        titleLabel = setupTitleLabel(for: self, with: "")
        (titleLabel, detailLabel) = setupTitleDetailLabels(for: self, title: "Permission", detail: "This app requeires some authorizations. Please check them below.")
        
        widthAnchor.constraint(equalToConstant: baseWidth).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAuthOption(with authOption: PKOption.Auth) {
        let authView = PokerOptionView(option: authOption)
        authView.titleLabel.text = authOption.title
        authView.imageView.image = authOption.image
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
            authView.imageView.image = UIImage(systemName: authOption.type.rawValue, withConfiguration: config)
        }
        authView.imageView.tintColor = PKColor.label

        addSubview(authView)
        
        authView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        authView.constraint(withLeadingTrailing: 20)
        authView.topAnchor.constraint(equalTo: (lastAuthView ?? detailLabel ?? titleLabel).bottomAnchor, constant: internalSpacing).isActive = true
        
        lastAuthView = authView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(authViewTapped(_:)))
        authView.addGestureRecognizer(tap)
    }
    
    @objc
    func authViewTapped(_ gesture: UITapGestureRecognizer) {
        guard
            let authOptionView = gesture.view as? PokerOptionView,
            let authType = (authOptionView.option as? PKOption.Auth)?.type
        else {
            fatalError("Cannot retrive Auth Options.")
        }
        
        switch authType {
        case .location: requestLocationAccess()
        case .photoLibrary: break
        case .notification: requestPushNotifications()
        default: break
        }
    }
    
    private func requestLocationAccess() {
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
//            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse: break
        @unknown default: break
        }
    }
    
    private func requestPushNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            // Enable or disable features based on authorization.
        }
    }
}
