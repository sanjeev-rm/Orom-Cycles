//
//  SupportEmail.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 07/08/23.
//

import Foundation
import UIKit
import SwiftUI

struct SupportEmail {
    let toAddress: String
    let subject: String
    let messageHeader: String
    var body: String {"""
    Application Name: \(Bundle.main.displayName)
    iOS: \(UIDevice.current.systemVersion)
    Application Version: \(Bundle.main.appVersion)
    Application Build: \(Bundle.main.appBuild)
    \(messageHeader)
    -----------------------------------------------
    """
    }
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)
                """)
            }
        }
    }
}
