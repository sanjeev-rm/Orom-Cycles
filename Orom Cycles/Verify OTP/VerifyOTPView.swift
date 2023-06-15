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
        NavigationView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Verify")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                
                TextField("Enter OTP", text: $otp)
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.width - 64, height: 44, alignment: .leading)
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    )
                
                HStack(alignment: .center) {
                    Spacer()
                    VStack(spacing: 8) {
                        Text("Enter the OTP sent to your email")
                        Text("Valid for 5 mins")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(.tertiaryLabel))
                    Spacer()
                }
                
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
                
                Spacer()
            }
            .padding(32)
        }
    }
}

struct VerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyOTPView()
    }
}
