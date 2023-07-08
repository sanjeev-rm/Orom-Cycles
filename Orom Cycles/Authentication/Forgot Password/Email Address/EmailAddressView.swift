//
//  EmailAddressView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct EmailAddressView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var emailAddressViewModel = ViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            baseView
                .navigationDestination(isPresented: $emailAddressViewModel.navigateToUpdatePasswordView) {
                    UpdatePasswordView()
                }
        } else {
            baseView
                .background(
                    Group {
                        NavigationLink(destination: UpdatePasswordView(), isActive: $emailAddressViewModel.navigateToUpdatePasswordView) {
                            EmptyView()
                        }
                    }
                )
        }
    }
}

struct EmailAddressView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAddressView()
    }
}



// MARK: - View Components

extension EmailAddressView {
    
    private var baseView: some View {
        VStack(alignment: .leading, spacing: 32) {
            title
            
            VStack(spacing: 16) {
                emailFieldWithFooter
                
                verifyButton
                
                seperatorLine
                
                loginButton
            }
            
            Spacer()
        }
        .padding(32)
    }
    
    /// Email Address Title
    private var title: some View {
        Text("Email Address")
            .font(.system(size: 24, weight: .bold, design: .default))
            .foregroundColor(Color(.secondaryLabel))
    }
    
    /// Email field with footer
    private var emailFieldWithFooter: some View {
        VStack(alignment: .leading, spacing: 3) {
            TextField("Vit Email Address", text: $emailAddressViewModel.email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .padding(16)
                .frame(height: 50)
                .background(.secondary.opacity(0.1))
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke()
                        .foregroundColor(emailAddressViewModel.emailValidity.isValid ?
                            .secondary.opacity(0.3) : Color(uiColor: .systemRed).opacity(0.3))
                )
            
            if !emailAddressViewModel.emailValidity.isValid {
                HStack {
                    Spacer()
                    Text(emailAddressViewModel.emailValidity.error.message)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: .systemRed))
                    Spacer()
                }
            }
            
            Text("Enter registered email")
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(.tertiaryLabel))
            .padding(.leading)
        }
    }
    
    /// Verify Button
    private var verifyButton: some View {
        HStack {
            Text("Verify")
                .font(.system(size: 24, weight: .semibold))
            
            Spacer()
            
            if emailAddressViewModel.showProgressView {
                ProgressView()
                    .tint(.accentColor)
                    .controlSize(.large)
            } else {
                Button {
                    emailAddressViewModel.sendEmail()
                } label: {
                    Image(systemName: "arrow.forward.circle")
                        .font(.system(size: 36))
                        .foregroundColor(.accentColor)
                }
                .disabled(emailAddressViewModel.isVerifyButtonDisabled)
            }
        }
    }
    
    /// Seperator Line
    private var seperatorLine: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray.opacity(0.5))
    }
    
    /// Login Button
    private var loginButton: some View {
        HStack {
            Button {
                authenticationViewModel.showForgotPasswordView = false
            } label: {
                HStack {
                    Text("Never mind")
                        .foregroundColor(.primary)
                    Text("Login")
                        .foregroundColor(.accentColor)
                        .underline()
                }
                .font(.system(size: 14))
            }
            .disabled(emailAddressViewModel.showProgressView)
        }
    }
}
