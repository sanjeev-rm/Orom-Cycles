//
//  SignUpViewViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 16/06/23.
//

import Foundation

extension SignUpView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        @Published var showProgressView: Bool = false
        
        @Published var showAlert: Bool = false
        @Published var alertMessage: String = ""
        @Published var alertType: AlertType = .basic
        
        @Published var isNameEmailValid: Bool = true
        @Published var isPasswordConfirmPasswordValid: Bool = true
        
        @Published var nameEmailError: SignUpError = .nameEmailInvalid
        @Published var passwordConfirmPasswordError: SignUpError = .passwordConfirmPasswordInvalid
        
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
        
        enum AlertType {
            case basic
            case success
            case failure
            case warning
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
                isNameEmailValid = false
                nameEmailError = .nameEmailEmpty
            } else {
                isNameEmailValid = true
            }
        }
        
        /// Function verifies Password & Confirm Password
        func checkPasswordConfirmPassword() {
            if password.isEmpty || confirmPassword.isEmpty {
                isPasswordConfirmPasswordValid = false
                passwordConfirmPasswordError = .passwordConfirmPasswordEmpty
            } else if password != confirmPassword {
                isPasswordConfirmPasswordValid = false
                passwordConfirmPasswordError = .passwordConfirmPasswordDontMatch
            } else {
                isPasswordConfirmPasswordValid = true
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
            guard isNameEmailValid && isPasswordConfirmPasswordValid else { return }
            
            showProgressView = true
            APIService().signUp(name: name, email: email, password: password, passwordConfirm: confirmPassword) { [unowned self] result in
                DispatchQueue.main.async {
                    self.showProgressView = false
                }
                switch result {
                case .success(let message):
                    self.showSignUpAlert(message: message, alertType: .success)
                case .failure(let error):
                    switch error {
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
        
        func showSignUpAlert(message: String, alertType: AlertType) {
            DispatchQueue.main.async {
                self.alertMessage = message
                self.alertType = alertType
                self.showAlert = true
            }
        }
    }
}
