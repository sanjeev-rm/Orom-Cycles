//
//  ForgotPasswordVerifyOTPView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct ForgotPasswordVerifyOTPView: View {
    
    @ObservedObject var forgotPasswordVerifyOTPViewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            title
            
            otpFieldWithFooter
            
            VStack(spacing: 16) {
                newPasswordButton
                
                seperatorLine
                
                resendOtpButton
            }
            
            Spacer()
        }
        .padding(32)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ForgotPasswordVerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordVerifyOTPView()
    }
}



// MARK: - View Components

extension ForgotPasswordVerifyOTPView {
    
    /// Verify Title
    private var title: some View {
        Text("Verify")
            .font(.system(size: 24, weight: .bold, design: .default))
            .foregroundColor(Color(.secondaryLabel))
    }
    
    /// OTP field with footer message
    private var otpFieldWithFooter: some View {
        VStack(alignment: .leading) {
            TextField("Enter OTP", text: $forgotPasswordVerifyOTPViewModel.otp)
                .textContentType(.oneTimeCode)
                .keyboardType(.numberPad)
                .padding(16)
                .frame(height: 50)
                .background(.secondary.opacity(0.2))
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke()
                        .foregroundColor(.secondary.opacity(0.3))
                )
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Enter the OTP sent to your email")
                Text("Valid for 5 mins")
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(.tertiaryLabel))
            .padding(.leading)
        }
    }
    
    /// New Password Button
    private var newPasswordButton: some View {
        HStack {
            Text("New Password")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            
            NavigationLink {
                UpdatePasswordView()
            } label: {
                Image(systemName: "arrow.forward.circle")
                    .font(.system(size: 36))
                    .foregroundColor(.accentColor)
            }
            .disabled(forgotPasswordVerifyOTPViewModel.isNewPasswordButtonDisabled)
        }
    }
    
    /// Seperator Line
    private var seperatorLine: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray.opacity(0.5))
    }
    
    /// Resend OTP Button
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
