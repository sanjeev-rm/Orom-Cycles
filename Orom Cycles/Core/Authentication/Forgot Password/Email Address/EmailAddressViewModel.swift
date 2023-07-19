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
        
        @Published var alert: OromAlert = OromAlert()
        
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
            
            AuthenticationAPIService().forgotPassword(email: email) { [unowned self] result in
                DispatchQueue.main.async {
                    self.showProgressView = false
                }
                
                switch result {
                case .success(let success):
                    // Showing OTP sent alert
                    self.showEmailAlert(message: success, alertType: .success)
                    DispatchQueue.main.async {
                        print(success)
                        // Setting email as valid
                        self.emailValidity.setValid()
                        //Storing the users email
                        Storage.forgotPasswordEmail = self.email
                        // Navigating to Update Password View
                        self.navigateToUpdatePasswordView = true
                    }
                case .failure(let failure):
                    switch failure {
                    case .noInternetConnection:
                        self.showEmailAlert(message: "Check internet connection", alertType: .customSystemImage(systemImage: "wifi.slash", color: Color(.tertiaryLabel)))
                    case .invalid:
                        DispatchQueue.main.async {
                            // Setting email as invalid
                            self.emailValidity.setInvalid(withError: .noSuchUser)
                        }
                    case .custom(let message):
                        self.showEmailAlert(message: message, alertType: .failure)
                    }
                    print("Invalid email : \(failure.localizedDescription)")
                }
            }
        }
        
        
        
        // MARK: - Alert function
        
        /// Function to show alert in Forgot password Email
        func showEmailAlert(message: String, alertType: OromAlert.AlertType) {
            DispatchQueue.main.async {
                self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
            }
        }
    }
}
