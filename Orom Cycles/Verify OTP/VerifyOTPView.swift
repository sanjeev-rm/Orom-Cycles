//
//  VerifyOTPView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct VerifyOTPView: View {
    
    @State var otp: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Verify")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.gray)
            
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
            
            Button {
                // Sign Up
            } label: {
                HStack {
                    Spacer()
                    Text("Sign Up")
                        .font(.system(size: 24, weight: .medium))
                        .frame(height: 44)
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
            
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
            
            Spacer()
        }
        .padding(32)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyOTPView()
    }
}
