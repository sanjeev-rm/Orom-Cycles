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
        
        /// Variable that shows whether the Name & Email is valid or not
        @Published var isNameEmailValid: Bool = true
        
        /// Variable that shows whether the Password & Confirm Password is valid or not
        @Published var isPasswordConfirmPasswordValid: Bool = true
        
        /// Conatins the error message for the name & email fields
        @Published var nameEmailErrorMessage: ErrorMessage = .nameEmailInvalid
        /// Contains the error message for the password & confirm password fields
        @Published var passwordErrorMessage: ErrorMessage = .passwordConfirmPasswordInvalid
        
        /// Error Messages
        enum ErrorMessage: String {
            case nameEmailEmpty = "Name & Email can't be empty"
            case nameEmailInvalid = "Invalid Name / Email"
            case passwordConfirmPasswordInvalid = "Invalid Password / Confirm Password"
            case passwordConfirmPasswordEmpty = "Password & Confirm Password can't be empty"
            case passwordConfirmPasswordDontMatch = "Password & Confirm Password don't match"
            case custom
        }
        
        @Published var isSigningUp: Bool = false
        @Published var showSignUpAlert: Bool = false
        @Published var signUpErrorMessage: String = ""
        
        
        
        // MARK: - UI Functions
        
        /// Function verifies data entered by the user
        func verifyUserData() {
            verifyNameAndEmail()
            verifyPasswordAndConfirmPassword()
        }
        
        /// Function verifies Name & Email
        func verifyNameAndEmail() {
            // Check if the name and email are empty
            // Check for the name and email constraints
            if name.isEmpty || email.isEmpty {
                isNameEmailValid = false
                nameEmailErrorMessage = .nameEmailEmpty
            } else {
                isNameEmailValid = true
            }
        }
        
        /// Function verifies Password & Confirm Password
        func verifyPasswordAndConfirmPassword() {
            // Check if any is empty
            // Check if they validate the constraints
            // Check if they match
            if password.isEmpty || confirmPassword.isEmpty {
                isPasswordConfirmPasswordValid = false
                passwordErrorMessage = .passwordConfirmPasswordEmpty
            } else if password != confirmPassword {
                isPasswordConfirmPasswordValid = false
                passwordErrorMessage = .passwordConfirmPasswordDontMatch
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
            WebService().signUp(name: name, email: email, password: password, passwordConfirm: confirmPassword) { result in
                switch result {
                case .success(let message):
                    self.showSignUpErrorAlert(errorMessage: message)
                case .failure(let error):
                    switch error {
                    case .userAlreadyExists:
                        self.showSignUpErrorAlert(errorMessage: "User already exists, please Login")
                    case .emailOrServerError:
                        self.showSignUpErrorAlert(errorMessage: "Make sure the email is an vit email ID.\nIf error persists, try again later.")
                    default:
                        self.showSignUpErrorAlert(errorMessage: "Unknown Error")
                    }
                }
            }
        }
        
        func startSigningUp() {
            isSigningUp = true
        }
        
        func stopSigningUp() {
            isSigningUp = false
        }
        
        func showSignUpErrorAlert(errorMessage: String) {
            DispatchQueue.main.async {
                self.signUpErrorMessage = errorMessage
                self.showSignUpAlert = true
            }
        }
    }
}
