//
//  VerificationAndNewPasswordService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation

extension APIService {
    
    enum ResetPasswordError: Error {
        case incorrectOtp
        case passwordsDontMatch
    }
    
    struct ResetPasswordRequestBody: Codable {
        var email: String
        var password: String
        var passwordConfirm: String
        var otp: String
    }
    
    struct ResetPasswordResponseBody: Codable {
        var status: String
    }
    
    func resetPassword(email: String, password: String, passwordConfirm: String, otp: String,
                       completion: @escaping (Result<String, ResetPasswordError>) -> Void) {
    }
}
