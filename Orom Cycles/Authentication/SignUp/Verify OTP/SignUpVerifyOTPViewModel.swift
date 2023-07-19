//
//  SignUpVerifyOTPViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation
import SwiftUI

extension SignUpVerifyOTPView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var otp: String = "" {
            didSet {
                isSignUpButtonDisabled = otp.count != 6
            }
        }
        
        @Published var isSignUpButtonDisabled: Bool = true
        
        @Published var otpValidity: ValidityAndError<ErrorMessage> = .init(isValid: true, error: .wrongOtp)
        
        @Published var isVerifying: Bool = false
        
        @Published var alert: OromAlert = OromAlert()
        
//        @AppStorage(Storage.Key.signUpEmail.rawValue) var email: String?
        
        enum ErrorMessage: String {
            case emptyOtp = "OTP can't be empty"
            case incompleteOtp = "OTP contains 6 digits"
            case wrongOtp = "Wrong OTP"
        }
        
        func checkOtp() -> Bool {
            if otp.isEmpty {
                otpValidity.setInvalid(withError: .emptyOtp)
                return false
            } else if otp.count != 6 {
                otpValidity.setInvalid(withError: .incompleteOtp)
                return false
            }
            otpValidity.setValid()
            return true
        }
        
        func verifyOtp(completion: @escaping (Bool) -> Void) {
            guard checkOtp() else { return }
            
            isVerifying = true
            
            guard let email = Storage.signUpEmail else { return }
            
            AuthenticationAPIService().signUpVerifyOtp(email: email, otp: otp) { [unowned self] result in
                DispatchQueue.main.async {
                    self.isVerifying = false
                }
                switch result {
                case .success(let token):
                    // Save jwt to the storage
                    print(token)
                    Storage.jsonWebToken = token
                    completion(true)
                case .failure(let failure):
                    switch failure {
                    case .invalidOtp:
                        otpValidity.setInvalid(withError: .wrongOtp)
                    case .noInternetConnection:
                        self.showSignUpVerifyAlert(message: "Check internet connection", alertType: .customSystemImage(systemImage: "wifi.slash", color: Color(.tertiaryLabel)))
                    case .custom(let message):
                        self.showSignUpVerifyAlert(message: message, alertType: .failure)
                    }
                    print(failure.localizedDescription)
                    otpValidity.setInvalid(withError: .wrongOtp)
                    completion(false)
                }
            }
        }
        
        // MARK: - Alert function
        
        /// Function to show alert in sign up
        func showSignUpVerifyAlert(message: String, alertType: OromAlert.AlertType) {
            DispatchQueue.main.async {
                self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
            }
        }
    }
}
