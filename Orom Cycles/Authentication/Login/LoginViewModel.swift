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
        
        /// Variable that shows whether the user is valid or not.
        @Published var isUserValid: Bool = true
        
        /// Error message to show below the fields.
        enum ErrorMessage: String {
            case emptyEmailPassword = "Email & Password can't be empty"
            case invalidEmailPassword = "Inavlid Email / Password"
            case incorrectEmailPassword = "Incorrect Email / Password"
        }
        @Published var errorMessage: ErrorMessage = .invalidEmailPassword
        
        @Published var isLoggingIn: Bool = false
        
        /// Function verifies the email and password entered by the user.
        func verifyUser() {
            // Check if the email or password is empty
            // Check if the entered email and passwrd is in the format of an email and password.
            // Send to backend and check if the user is valid.
            if email.isEmpty || password.isEmpty {
                isUserValid = false
                errorMessage = .emptyEmailPassword
            } else {
                // Send to API and verify user.
                isUserValid = true
            }
        }
        
        /// Function that does everything that needs to be done when the fullScreen cover dismisses.
        func onDismissFullScreenCover() {
            isUserValid = true
            email = ""
            password = ""
        }
        
        func isLoginButtonDisabled() -> Bool {
            return email.isEmpty || password.isEmpty
        }
    }
}
