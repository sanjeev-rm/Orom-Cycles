//
//  ToastAlert.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 10/07/23.
//

import Foundation
import SwiftUI

/// Tye types of alerts
enum AlertType {
    case basic
    case success
    case failure
    case warning
    case customSystemImage(systemImage: String, color: Color)
    case customImage(image: String, color: Color)
}

/// The ToastAlert type
/// - showAlert : boolean value sets whether to show the alert or not
/// - alertType : the type of alert you want to show
/// - message : the message to show when showing the alert
struct ToastAlert {
    var showAlert: Bool = false
    var alertType: AlertType = .basic
    var message: String = ""
}
