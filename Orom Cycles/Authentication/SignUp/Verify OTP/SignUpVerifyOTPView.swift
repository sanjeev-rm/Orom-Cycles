//
//  VerifyOTPView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct SignUpVerifyOTPView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @ObservedObject var signUpVerifyOtpViewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            title
            
            otpFieldWithFooter
            
            verifyButton
            
            resendOtpButton
            
            Spacer()
        }
        .padding(32)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVerifyOTPView()
    }
}



// MARK: - View Components

extension SignUpVerifyOTPView {
    
    /// Verify Title
    private var title: some View {
        Text("Verify")
            .font(.system(size: 24, weight: .bold, design: .default))
            .foregroundColor(.gray)
    }
    
    /// OTP field with footer
    private var otpFieldWithFooter: some View {
        VStack(alignment: .leading) {
            TextField("Enter OTP", text: $signUpVerifyOtpViewModel.otp)
                .textContentType(.oneTimeCode)
                .keyboardType(.numberPad)
                .padding(16)
                .frame(height: 50)
                .background(.secondary.opacity(0.2))
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke()
                        .foregroundColor(signUpVerifyOtpViewModel.otpValidity.isValid ? .secondary.opacity(0.3) : Color(uiColor: .systemRed).opacity(0.3))
                )
                .onSubmit {
                    signUpVerifyOtpViewModel.verifyOtp { success in
                        authenticationViewModel.isLoggedIn = success
                    }
                }
            
            if !signUpVerifyOtpViewModel.otpValidity.isValid {
                HStack(alignment: .center) {
                    Spacer()
                    Text(signUpVerifyOtpViewModel.otpValidity.error.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(UIColor.systemRed))
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Enter the OTP sent to your email")
                Text("Valid for 5 mins")
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(.tertiaryLabel))
            .padding(.leading)
        }
    }
    
    /// Verify button
    private var verifyButton: some View {
        
        Button {
            // Verify OTP
            signUpVerifyOtpViewModel.verifyOtp { success in
                authenticationViewModel.updateLoggedInStatus(success)
            }
        } label: {
            HStack {
                Spacer()
                Text(signUpVerifyOtpViewModel.isVerifying ? "Verifying ..." : "Verify")
                    .font(.system(size: 24, weight: .medium))
                    .frame(height: 44)
                Spacer()
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(signUpVerifyOtpViewModel.isSignUpButtonDisabled || signUpVerifyOtpViewModel.isVerifying)
    }
    
    /// Resend OTP button
    private var resendOtpButton: some View {
        HStack {
            Spacer()
            Button {
                // Resend OTP
            } label: {
                Text("Resend OTP")
                    .foregroundColor(.accentColor)
                    .underline()
                    .font(.system(size: 12))
            }
            Spacer()
        }
    }
}
