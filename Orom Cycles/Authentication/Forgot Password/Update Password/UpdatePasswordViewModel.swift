//
//  UpdatePasswordViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation
import SwiftUI

extension UpdatePasswordView {
    @MainActor class ViewModel: ObservableObject {
        @Published var otp: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        @Published var otpValidity: ValidityAndError = .init(isValid: true)
        @Published var passwordConfirmPasswordValidity: ValidityAndError = .init(isValid: true)
        
        @Published var isPasswordUpdating: Bool = false
        
        enum ErrorMessage: String {
            case error = "Error"
            case otpInvalid = "Incorrect Otp"
            case otpMustHave6Digits = "Otp consists of 6 digits"
            case passwordConfirmPasswordEmpty = "Password & Confirm Password can't be empty"
            case passwordConfirmPasswordInvalid = "Invalid Password / Confirm Password"
            case passwordConfirmPasswordDontMatch = "Password & Confirm Password don't match"
        }
        
        /// Structure to represent wether something is valid or not
        /// - isValid --> true if valid and false otherwise
        /// - errorMessage--> The error message that can be used when the isValid is false
        struct ValidityAndError {
            var isValid: Bool
            var errorMessage: ErrorMessage = .error
        }
        
        /// Checks the given otp.
        func checkOtp() {
            if otp.isEmpty || otp.count != 6 {
                otpValidity = .init(isValid: false, errorMessage: .otpMustHave6Digits)
            } else {
                otpValidity = .init(isValid: true)
            }
        }
        
        /// Checks the given password and confirm password.
        func checkPasswordConfirmPassword() {
            if password.isEmpty || confirmPassword.isEmpty {
                passwordConfirmPasswordValidity = .init(isValid: false, errorMessage: .passwordConfirmPasswordEmpty)
            } else if password != confirmPassword {
                passwordConfirmPasswordValidity = .init(isValid: false, errorMessage: .passwordConfirmPasswordDontMatch)
            } else {
                passwordConfirmPasswordValidity = .init(isValid: true)
            }
        }
        
        /// Let's us know if the Update Button is disabled or not.
        /// Returns true if the update button is disabled.
        func isUpdateButtonDisabled() -> Bool {
            if otp.isEmpty ||
               otp.count != 6 ||
               password.isEmpty ||
               confirmPassword.isEmpty ||
               password != confirmPassword {
                return true
            }
            return false
        }
    }
}
