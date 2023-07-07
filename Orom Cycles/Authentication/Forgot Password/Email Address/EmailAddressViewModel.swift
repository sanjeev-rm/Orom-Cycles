//
//  EmailAddressViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation
import SwiftUI

extension EmailAddressView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var email: String = "" {
            didSet {
                isVerifyButtonDisabled = email.isEmpty
            }
        }
        
        @Published var emailValidity: ValidityAndError<ForgotPasswordEmailError> = .init(isValid: true, error: .invalid)
        
        @Published var isVerifyButtonDisabled: Bool = true
        
        @Published var showProgressView: Bool = false
        
        @Published var navigateToUpdatePasswordView: Bool = false
        
        /// The email stored in systems memeory
        @AppStorage(StorageKey.forgotPasswordEmail.rawValue) var storedEmail: String?
        
        /// Error for Forgot Password Email
        enum ForgotPasswordEmailError {
            case invalid
            case noSuchUser
            
            var message: String {
                switch self {
                case .invalid: return "Invalid Email"
                case .noSuchUser: return "No user with that email"
                }
            }
        }
        
        
        // MARK: - API function
        
        func sendEmail() {
            showProgressView = true
            
            APIService().forgotPassword(email: email) { [unowned self] result in
                DispatchQueue.main.async {
                    self.showProgressView = false
                }
                
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        print(success)
                        // Setting email as valid
                        self.emailValidity.setValid()
                        //Storing the users email
                        self.storedEmail = self.email
                        // Navigating to Update Password View
                        self.navigateToUpdatePasswordView = true
                    }
                case .failure(let failure):
                    DispatchQueue.main.async {
                        // Setting email as invalid
                        self.emailValidity.setInvalid(withError: .noSuchUser)
                    }
                    print("Invalid email : \(failure.localizedDescription)")
                }
            }
        }
    }
}
