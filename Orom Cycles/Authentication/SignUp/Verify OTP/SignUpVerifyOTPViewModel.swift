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
        
        @Published var isOtpValid: Bool = true
        
        enum ErrorMessage: String {
            case emptyOtp = "OTP can't be empty"
            case incompleteOtp = "OTP contains 6 digits"
            case wrongOtp = "Wrong OTP"
        }
        @Published var otpErrorMessage: ErrorMessage = .wrongOtp
        
        @Published var isVerifying: Bool = false
        
        func verifyOtp() {
            if otp.isEmpty {
                isOtpValid = false
                otpErrorMessage = .emptyOtp
            } else if otp.count != 6 {
                isOtpValid = false
                otpErrorMessage = .incompleteOtp
            } else {
                // VerifyOTP with backend.
                // set to true if valid.
                isOtpValid = true
            }
        }
    }
}
