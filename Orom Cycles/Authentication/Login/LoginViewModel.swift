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
        
        var isLoginButtonDisabled: Bool {
            email.isEmpty || password.count < 8
        }
        
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
        
        /// Function verifies the email and password entered by the user.
        func checkEmailPassword() {
            if email.isEmpty || password.count < 8 {
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
            APIService().login(email: email, password: password) { [unowned self] result in
                DispatchQueue.main.async {
                    self.showProgressView = false
                }
                switch result {
                case .success(let token):
                    print(token)
                    // Save the token in user defaults.
                    completion(true)
                case .failure(let loginError):
                    print(loginError.localizedDescription)
                    DispatchQueue.main.async {
                        self.emailPasswordValidity.setInvalid(withError: .incorrectEmailPassword)
                    }
                }
            }
        }
    }
}
