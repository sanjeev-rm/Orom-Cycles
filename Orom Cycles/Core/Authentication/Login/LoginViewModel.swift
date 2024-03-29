//
//  LoginViewViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 16/06/23.
//

import Foundation
import SwiftUI

extension LoginView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var email: String = ""
        @Published var password: String = ""
        
        @Published var showProgressView: Bool = false
        
        @Published var emailPasswordValidity: ValidityAndError<LoginError> = .init(isValid: true, error: .invalidEmailPassword)
        
        @Published var alert: OromAlert = OromAlert()
        
        var isLoginButtonDisabled: Bool {
            email.isEmpty || password.isEmpty
        }
        
        // MARK: - Login Error model
        
        enum LoginError: Error {
            case emptyEmailPassword
            case invalidEmailPassword
            case incorrectEmailPassword
            
            var message: String {
                switch self {
                case .emptyEmailPassword: return "Email & Password can't be empty"
                case .invalidEmailPassword: return "Inavlid Email / Password"
                case .incorrectEmailPassword: return "Incorrect Email / Password"
                }
            }
        }
        
        
        
        // MARK: - UI functions
        
        /// Function verifies the email and password entered by the user.
        func checkEmailPassword() {
            if email.isEmpty || password.isEmpty {
                emailPasswordValidity.setInvalid(withError: .emptyEmailPassword)
            } else {
                emailPasswordValidity.setValid()
            }
        }
        
        /// Function that does everything that needs to be done when the fullScreen cover dismisses.
        func onDismissFullScreenCover() {
            emailPasswordValidity.setValid()
            email = ""
            password = ""
        }
        
        
        
        // MARK: - API functions
        
        func login(completion: @escaping (Bool) -> Void) {
            checkEmailPassword()
            guard emailPasswordValidity.isValid else { return }
            
            showProgressView = true
            AuthenticationAPIService().login(email: email, password: password) { [unowned self] result in
                DispatchQueue.main.async {
                    self.showProgressView = false
                }
                switch result {
                case .success(let token):
                    // Save the token in user defaults.
                    print(token)
                    Storage.jsonWebToken = token
                    completion(true)
                case .failure(let loginError):
                    switch loginError {
                    case .noInternetConnection:
                        self.showLogInAlert(message: "Check internet connection", alertType: .customSystemImage(systemImage: "wifi.slash", color: Color(.tertiaryLabel)))
                    case .invalidEmailPassword:
                        DispatchQueue.main.async {
                            self.emailPasswordValidity.setInvalid(withError: .incorrectEmailPassword)
                        }
                    case .custom(let errorMessage):
                        self.showLogInAlert(message: errorMessage, alertType: .warning)
                    }
                }
            }
        }
        
        
        
        // MARK: - Login Alert function
        
        /// Function shows alert to the user in Login page
        func showLogInAlert(message: String, alertType: OromAlert.AlertType) {
            DispatchQueue.main.async {
                self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
            }
        }
    }
}
