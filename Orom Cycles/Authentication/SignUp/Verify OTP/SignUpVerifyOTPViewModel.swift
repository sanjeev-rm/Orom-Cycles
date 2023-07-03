//
//  SignUpVerifyOTPViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation

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
        
        enum ErrorMessage: String {
            case emptyOtp = "OTP can't be empty"
            case incompleteOtp = "OTP contains 6 digits"
            case wrongOtp = "Wrong OTP"
        }
        
        func verifyOtp() {
            if otp.isEmpty {
                otpValidity.setInvalid(withError: .emptyOtp)
            } else if otp.count != 6 {
                otpValidity.setInvalid(withError: .incompleteOtp)
            } else {
                // VerifyOTP with backend.
                // set to true if valid.
                otpValidity.setValid()
            }
        }
    }
}
