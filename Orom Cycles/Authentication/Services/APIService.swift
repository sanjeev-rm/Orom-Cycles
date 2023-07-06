//
//  APIService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 19/06/23.
//

import Foundation
import SwiftUI

/// Class responsible for APIService functions
class APIService {
    
    static let shared = APIService()
    
    /// The Login API URL in string
    final var LOGIN_URL = "https://geoapi-production-8c7a.up.railway.app/api/v1/users/login"
    
    /// Sign Up URL
    final var SIGN_UP_URL = "https://geoapi-production-8c7a.up.railway.app/api/v1/users/signup"
    
    /// The SignUp verify URL
    final var SIGN_UP_VERIFY_URL = "https://geoapi-production-8c7a.up.railway.app/api/v1/users/signup-verify"
}
