//
//  PokerDateView.swift
//  PokerCard
//
//  Created by Nemo on 2020/3/27.
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

/// Base Poker Date View which let user pick date & time.
public class PokerDateView: PokerAlertView {
    
    // Picker for dateView
    public let datePicker: UIDatePicker = UIDatePicker(frame: CGRect.zero)
    
    /// input date closure
    internal var inputDate: ((_ date: Date) -> Void)?
    
    internal let pickerContainerViewHeight: CGFloat = 150
    
    internal let pickerContainerView = PKContainerView()
    
    convenience init(title: String,
                     detail: String? = nil,
                     pickerMode: UIDatePicker.Mode = .date,
                     defaultTime: Date)
    {
        self.init(title: title, detail: detail)
        
        datePicker.datePickerMode = pickerMode
        datePicker.date = defaultTime
        
        setupDatePickerView()
    }
    
    private func setupDatePickerView() {

        pickerContainerView.layer.cornerRadius = 8
        insertSubview(pickerContainerView, at: 0)
        
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.topAnchor.constraint(equalTo: (detailLabel ?? titleLabel).bottomAnchor, constant: lineSpacing).isActive = true
        pickerContainerView.constraint(withLeadingTrailing: titleSpacing)
        pickerContainerView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -lineSpacing).isActive = true
        pickerContainerView.heightAnchor.constraint(equalToConstant: pickerContainerViewHeight).isActive = true
        
        pickerContainerView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.constraint(withLeadingTrailing: 0)
        datePicker.constraint(withTopBottom: 0)
        
    }
    
}
