//
//  ForgotPasswordViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation
import SwiftUI

//class ForgotPasswordViewModel: ObservableObject {
//
//    // MARK: - EmailAddress View
//
//    @Published var email: String = "" {
//        didSet {
//            isVerifyButtonDisabled = email.isEmpty
//        }
//    }
//    @Published var isVerifyButtonDisabled: Bool = true
//
//
//    // MARK: - Verify OTP View
//
//    @Published var otp: String = "" {
//        didSet {
//            isNewPasswordButtonDisabled = otp.isEmpty
//        }
//    }
//    @Published var isNewPasswordButtonDisabled: Bool = true
//
//    // MARK: - New Password View
//
//    @Published var password: String = ""
//    @Published var confirmPassword: String = ""
//
//    @Published var isPasswordConfirmPasswordValid: Bool = true
//
//    enum ErrorMessage: String {
//        case passwordConfirmPasswordEmpty = "Password & Confirm Password can't be empty"
//        case passwordConfirmPasswordInvalid = "Invalid Password / Confirm Password"
//        case passwordConfirmPasswordDontMatch = "Password & Confirm Password don't match"
//    }
//    @Published var passwordErrorMessage: ErrorMessage = .passwordConfirmPasswordInvalid
//
//    /// Verifies the given password and confirm password.
//    func verifyPasswords() {
//        if password.isEmpty || confirmPassword.isEmpty {
//            isPasswordConfirmPasswordValid = false
//            passwordErrorMessage = .passwordConfirmPasswordEmpty
//        } else if password != confirmPassword {
//            isPasswordConfirmPasswordValid = false
//            passwordErrorMessage = .passwordConfirmPasswordDontMatch
//        } else {
//            isPasswordConfirmPasswordValid = true
//        }
//    }
//
//    /// Let's us know if the Update Button is disabled or not.
//    /// Returns true if the update button is disabled.
//    func isUpdateButtonDisabled() -> Bool {
//        if password.isEmpty ||
//           confirmPassword.isEmpty ||
//           password != confirmPassword {
//            return true
//        }
//        return false
//    }
//}
