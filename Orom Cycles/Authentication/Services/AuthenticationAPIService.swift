//
//  APIService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 19/06/23.
//

import Foundation
import SwiftUI

/// Class responsible for APIService functions
class AuthenticationAPIService {
    
    static let shared = AuthenticationAPIService()
    
    /// The Login API URL in string
    final var LOGIN_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/login"
    
    /// Sign Up URL
    final var SIGN_UP_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/signup"
    
    /// The SignUp verify URL
    final var SIGN_UP_VERIFY_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/signup-verify"
    
    /// The Fogot password URL
    final var FORGOT_PASSWORD_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/forgotPassword"
    
    /// The Reset password URL
    final var RESET_PASSWORD_URL = "https://geoapi-orom-cycles.onrender.com/api/v1/users/resetPassword"
}
