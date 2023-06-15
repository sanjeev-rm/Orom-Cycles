//
//  ForgotPasswordVerifyOTPView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct ForgotPasswordVerifyOTPView: View {
    
    @State private var otp: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Verify")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(.secondaryLabel))
            
            VStack(alignment: .leading) {
                TextField("Enter OTP", text: $otp)
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
            
            VStack(spacing: 16) {
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
                    .disabled(isNewPasswordButtonDisabled())
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.5))
                
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



extension ForgotPasswordVerifyOTPView {
    
    private func isNewPasswordButtonDisabled() -> Bool {
        return otp.isEmpty
    }
}
