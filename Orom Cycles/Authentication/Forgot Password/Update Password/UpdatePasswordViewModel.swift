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
        
        @Published var otpValidity: ValidityAndError<ErrorMessage> = .init(isValid: true, error: .error)
        @Published var passwordConfirmPasswordValidity: ValidityAndError<ErrorMessage> = .init(isValid: true, error: .error)
        
        @Published var isPasswordUpdating: Bool = false
        
        enum ErrorMessage: String {
            case error = "Error"
            case otpInvalid = "Incorrect Otp"
            case otpMustHave6Digits = "Otp consists of 6 digits"
            case passwordConfirmPasswordEmpty = "Password & Confirm Password can't be empty"
            case passwordConfirmPasswordInvalid = "Invalid Password / Confirm Password"
            case passwordConfirmPasswordDontMatch = "Password & Confirm Password don't match"
        }
        
        /// Checks the given otp.
        func checkOtp() {
            if otp.isEmpty || otp.count != 6 {
                otpValidity.setInvalid(withError: .otpMustHave6Digits)
            } else {
                otpValidity.setValid()
            }
        }
        
        /// Checks the given password and confirm password.
        func checkPasswordConfirmPassword() {
            if password.isEmpty || confirmPassword.isEmpty {
                passwordConfirmPasswordValidity.setInvalid(withError: .passwordConfirmPasswordEmpty)
            } else if password != confirmPassword {
                passwordConfirmPasswordValidity.setInvalid(withError: .passwordConfirmPasswordDontMatch)
            } else {
                passwordConfirmPasswordValidity.setValid()
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
