//
//  UIApplication+.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/29/24.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
