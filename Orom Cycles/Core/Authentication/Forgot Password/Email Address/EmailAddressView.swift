//
//  EmailAddressView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct EmailAddressView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var emailAddressViewModel = ViewModel()
    
    @FocusState private var focusField: FocusField?
    
    private enum FocusField {
        case email
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                baseView
                    .navigationDestination(isPresented: $emailAddressViewModel.navigateToUpdatePasswordView) {
                        UpdatePasswordView()
                    }
            }
        }
        .toast(isPresenting: $emailAddressViewModel.alert.showAlert, duration: 8.0, tapToDismiss: true) {
            return OromAlert.getAlertToast(with: emailAddressViewModel.alert.message, emailAddressViewModel.alert.alertType)
        }
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
        .padding(24)
        .navigationBarTitleDisplayMode(.inline)
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
                .background(Color(oromColor: .textFieldBackground))
                .cornerRadius(16)
                .focused($focusField, equals: .email)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke()
                        .foregroundColor(emailAddressViewModel.emailValidity.isValid ?
                            .clear : Color(uiColor: .systemRed))
                )
                .shadow(color: Color(oromColor: .shadowColor), radius: (focusField == .email) ? 3 : 0)
                .disabled(emailAddressViewModel.showProgressView)
            
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
                .foregroundColor(Color(oromColor: .labelPrimary))
            
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



// MARK: - Preview
struct EmailAddressView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAddressView()
            .environmentObject(AuthenticationViewModel())
    }
}
