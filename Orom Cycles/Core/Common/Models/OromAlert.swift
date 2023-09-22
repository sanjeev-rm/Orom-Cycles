//
//  OromAlert.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 10/07/23.
//

import Foundation
import SwiftUI
import AlertToast

/// The OromAlert type
/// - showAlert : boolean value sets whether to show the alert or not
/// - alertType : the type of alert you want to show
/// - message : the message to show when showing the alert
struct OromAlert {
    
    var showAlert: Bool = false
    var alertType: AlertType = .basic
    var message: String = ""
    
    /// Tye types of alerts
    enum AlertType {
        case basic
        case success
        case failure
        case warning
        case loading
        case customSystemImage(systemImage: String, color: Color)
        case customImage(image: String, color: Color)
    }
    
    /// Function that returns an alert of type AlertToast
    /// - parameter message: The message to show with the alert
    /// - parameter alertType: An alert of type OromAlertType the type of alert to show
    static func getAlertToast(with message: String? = nil, _ alertType: AlertType, displayMode: AlertToast.DisplayMode = .hud) -> AlertToast {
        let alertToastType: AlertToast.AlertType
        switch alertType {
        case .basic: alertToastType = .regular
        case .success: alertToastType = .complete(Color(uiColor: .systemGreen))
        case .failure: alertToastType = .error(Color(uiColor: .systemRed))
        case .warning: alertToastType = .systemImage("exclamationmark.triangle.fill", Color(uiColor: .systemYellow))
        case .loading: alertToastType = .loading
        case .customSystemImage(let systemImage, let color): alertToastType = .systemImage(systemImage, color)
        case .customImage(let image, let color): alertToastType = .image(image, color)
        }
        return AlertToast(displayMode: displayMode,
                          type: alertToastType,
                          subTitle: message)
    }
}
