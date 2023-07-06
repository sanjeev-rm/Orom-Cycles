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
        
        @AppStorage(StorageKey.signUpEmail.rawValue) var email: String?
        
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
            
            guard let email = email else { return }
            
            APIService().signUpVerifyOtp(email: email, otp: otp) { [unowned self] result in
                DispatchQueue.main.async {
                    self.isVerifying = false
                }
                switch result {
                case .success(let jwt):
                    // Prints the Jason Web Token
                    print(jwt)
                    completion(true)
                case .failure(let failure):
                    print(failure.localizedDescription)
                    completion(false)
                }
            }
        }
    }
}
