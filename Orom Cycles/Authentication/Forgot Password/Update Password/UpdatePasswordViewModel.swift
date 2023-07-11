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
        
        @Published var alert: OromAlert = OromAlert()
        
        @AppStorage(StorageKey.forgotPasswordEmail.rawValue) var email: String?
        
        enum ErrorMessage: String {
            case error = "Error"
            case otpInvalid = "Incorrect Otp"
            case otpMustHave6Digits = "Otp consists of 6 digits"
            case passwordConfirmPasswordEmpty = "Password & Confirm Password can't be empty"
            case passwordConfirmPasswordInvalid = "Invalid Password / Confirm Password"
            case passwordConfirmPasswordDontMatch = "Password & Confirm Password don't match"
        }
        
        // MARK: - Functions
        
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
        
        // MARK: - API functions
        
        func updatePassword(completion: @escaping(Bool) -> Void) {
            isPasswordUpdating = true
            
            guard let email = email else { return }
            
            APIService().resetPassword(email: email, password: password, passwordConfirm: confirmPassword, otp: otp) { [unowned self] result in
                DispatchQueue.main.async {
                    self.isPasswordUpdating = false
                    
                    switch result {
                    case .success(_):
                        completion(true)
                        print("Updated Password")
                    case .failure(let error):
                        completion(false)
                        switch error {
                        case .noInternetConnection:
                            self.showUpdatePasswordAlert(message: "Check internet connection", alertType: .customSystemImage(systemImage: "wifi.slash", color: Color(.tertiaryLabel)))
                        case .incorrectOtp:
                            self.otpValidity.setInvalid(withError: .otpInvalid)
                        case .passwordsDontMatch:
                            self.passwordConfirmPasswordValidity.setInvalid(withError: .passwordConfirmPasswordDontMatch)
                        default:
                            print("Unidentified Error")
                        }
                    }
                }
            }
        }
        
        
        
        // MARK: - Alert function
        
        /// Function to show update password alert
        func showUpdatePasswordAlert(message: String, alertType: OromAlert.AlertType) {
            DispatchQueue.main.async {
                self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
            }
        }
    }
}
