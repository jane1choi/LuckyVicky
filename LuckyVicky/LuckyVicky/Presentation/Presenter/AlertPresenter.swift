//
//  AlertPresenter.swift
//  LuckyVicky
//
//  Created by EUNJU on 9/4/24.
//

import UIKit

final class AlertPresenter: ObservableObject {
    var alertType: AlertType
    var alertTitle: String?
    var alertMessage: String
    var action: (() -> Void)?
    @Published var isAlertPresented: Bool{
        didSet {
            if isAlertPresented {
                UIView.setAnimationsEnabled(false)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    UIView.setAnimationsEnabled(true)
                }
            }
        }
    }
    
    init(alertType: AlertType = .basic,
         alertTitle: String? = .none,
         alertMessage: String,
         action: (() -> Void)? = nil,
         isAlertPresented: Bool = false
    ) {
        self.alertType = alertType
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.action = action
        self.isAlertPresented = isAlertPresented
    }
    
    func presentTwoButtonAlert(title: AlertMessage, message: AlertMessage, action: (() -> Void)?) {
        alertType = .twoButton
        alertTitle = title.description
        alertMessage = message.description
        isAlertPresented = true
        self.action = action
    }
    
    func presentAlert(message: AlertMessage) {
        alertMessage = message.description
        isAlertPresented = true
    }
}
