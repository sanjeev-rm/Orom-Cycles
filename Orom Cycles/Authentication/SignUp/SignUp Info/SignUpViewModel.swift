//
//  SignUpViewViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 16/06/23.
//

import Foundation
import SwiftUI

extension SignUpView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        @Published var showProgressView: Bool = false
        
        @Published var alert: OromAlert = OromAlert()
        
        @Published var nameEmailValidity: ValidityAndError<SignUpError> = .init(isValid: true, error: .nameEmailInvalid)
        @Published var passwordConfirmPasswordErrorValidity: ValidityAndError<SignUpError> = .init(isValid: true, error: .passwordConfirmPasswordInvalid)
        
        @Published var navigateToVerification: Bool = false
        
        /// The stored email
        @AppStorage(StorageKey.signUpEmail.rawValue) var savedEmail: String?
        
        // MARK: - Sign Up Error Model
        
        enum SignUpError: Error {
            case nameEmailEmpty
            case nameEmailInvalid
            case passwordConfirmPasswordInvalid
            case passwordConfirmPasswordEmpty
            case passwordConfirmPasswordDontMatch
            case userAlreadyExists
            case emailOrServer
            case unknown
            
            var message: String {
                switch self {
                case .nameEmailEmpty: return "Name & Email can't be empty"
                case .nameEmailInvalid: return "Invalid Name / Email"
                case .passwordConfirmPasswordEmpty: return "Password & Confirm Password can't be empty"
                case .passwordConfirmPasswordInvalid: return "Invalid Password / Confirm Password"
                case .passwordConfirmPasswordDontMatch: return "Password & Confirm Password don't match"
                case .userAlreadyExists: return "User already exists, please Login"
                case .emailOrServer: return "Make sure the email is an vit email ID.\nIf error persists, try again later."
                case .unknown: return "Unknown Error"
                }
            }
        }
        
        
        
        // MARK: - UI Functions
        
        /// Function verifies data entered by the user
        func checkUserData() {
            checkNameEmail()
            checkPasswordConfirmPassword()
        }
        
        /// Function verifies Name & Email
        func checkNameEmail() {
            if name.isEmpty || email.isEmpty {
                nameEmailValidity.setInvalid(withError: .nameEmailEmpty)
            } else {
                nameEmailValidity.setValid()
            }
        }
        
        /// Function verifies Password & Confirm Password
        func checkPasswordConfirmPassword() {
            if password.isEmpty || confirmPassword.isEmpty {
                passwordConfirmPasswordErrorValidity.setInvalid(withError: .passwordConfirmPasswordEmpty)
            } else if password != confirmPassword {
                passwordConfirmPasswordErrorValidity.setInvalid(withError: .passwordConfirmPasswordDontMatch)
            } else {
                passwordConfirmPasswordErrorValidity.setValid()
            }
        }
        
        /// Function returns whether the Verify button is disabled or not.
        func isVerifyButtonDisabled() -> Bool {
            if name.isEmpty ||
               email.isEmpty ||
               password.count < 8 ||
               confirmPassword.count < 8 ||
               password != confirmPassword {
                return true
            }
            return false
        }
        
        
        
        // MARK: - API functions
        
        func signUp() {
            checkUserData()
            guard nameEmailValidity.isValid && passwordConfirmPasswordErrorValidity.isValid else { return }
            
            showProgressView = true
            APIService().signUp(name: name, email: email, password: password, passwordConfirm: confirmPassword) { [unowned self] result in
                DispatchQueue.main.async {
                    self.showProgressView = false
                }
                switch result {
                case .success(let message):
                    self.showSignUpAlert(message: message, alertType: .success)
                    DispatchQueue.main.async {
                        // Saving email to storage
                        self.savedEmail = self.email
                        // Navigating to Verification
                        self.navigateToVerification = true
                    }
                case .failure(let error):
                    switch error {
                    case .noInternetConnection:
                        self.showSignUpAlert(message: "Check internet connection", alertType: .customSystemImage(systemImage: "wifi.slash", color: Color(.tertiaryLabel)))
                    case .userAlreadyExists:
                        self.showSignUpAlert(message: SignUpError.userAlreadyExists.message, alertType: .warning)
                    case .emailOrServerError:
                        self.showSignUpAlert(message: SignUpError.emailOrServer.message, alertType: .failure)
                    default:
                        self.showSignUpAlert(message: SignUpError.unknown.message, alertType: .failure)
                    }
                }
            }
        }
        
        
        
        // MARK: - Alert Function
        
        /// Function to show an alert in signup
        func showSignUpAlert(message: String, alertType: OromAlert.AlertType) {
            DispatchQueue.main.async {
                self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
            }
        }
    }
}
