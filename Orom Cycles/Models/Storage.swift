//
//  StorageKey.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation
import SwiftUI

class Storage {
    
    /// Keys for storing in UserDefaults / AppStorage
    enum Key: String {
        case isLoggedIn = "isLoggedIn"
        case signUpEmail = "signUpEmail"
        case forgotPasswordEmail = "forgotPasswordEmail"
        case jwt = "jsonWebToken"
        case walletCardGradientColors = "walletCardGradientColor"
    }
    
    /// The Email used during the process of signup
    @AppStorage(Key.signUpEmail.rawValue) static var signUpEmail: String?
    
    /// The Email used during the process of forgotPassword
    @AppStorage(Key.forgotPasswordEmail.rawValue) static var forgotPasswordEmail: String?
    
    /// The Json Web Token Stored in the Disk
    @AppStorage(Key.jwt.rawValue) static var jsonWebToken: String?
    
    /// The WalletCardGradientColors chosen by user
    @AppStorage(Key.walletCardGradientColors.rawValue) static var walletCardGradientColor: Data = Data()
    /// Stores the new value as the Wallet Card Gradient Color
    static func setWalletCardGradientColor(_ newValue: WalletCardGradientColor) {
        if let newData = try? JSONEncoder().encode(newValue) {
            walletCardGradientColor = newData
        }
    }
    /// Gets the stored Wallet Card Gradient Color
    static func getWalletCardGradientColor() -> WalletCardGradientColor {
        if let storedData = try? JSONDecoder().decode(WalletCardGradientColor.self, from: walletCardGradientColor) {
            return storedData
        }
        return .accentColor
    }
}
