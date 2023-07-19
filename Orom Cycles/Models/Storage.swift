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
    }
    
    /// The Email used during the process of signup
    @AppStorage(Key.signUpEmail.rawValue) static var signUpEmail: String?
    
    /// The Email used during the process of forgotPassword
    @AppStorage(Key.forgotPasswordEmail.rawValue) static var forgotPasswordEmail: String?
    
    /// The Json Web Token Stored in the Disk
    @AppStorage(Key.jwt.rawValue) static var jsonWebToken: String?
}
