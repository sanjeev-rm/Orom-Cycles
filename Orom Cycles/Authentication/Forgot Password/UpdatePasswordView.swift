//
//  UpdatePasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct UpdatePasswordView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @FocusState private var focusField: FocusField?
    
    @State private var isPasswordConfirmPasswordValid: Bool = true
    @State private var passwordConfirmPasswordMatch: Bool = true
    
    private enum FocusField {
        case password
        case confirmPassword
    }
    
    private enum ErrorMessage: String {
        case passwordConfirmPasswordInvalid = "Invalid Password / Confirm Password"
        case passwordConfirmPasswordDontMatch = "Password & Confirm Password don't match"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            title
            
            passwordConfirmPasswordFields
            
            updatePasswordButton
            
            Spacer()
        }
        .padding(32)
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}



extension UpdatePasswordView {
    
    /// New Password Title
    private var title: some View {
        Text("New Password")
            .font(.system(size: 24, weight: .bold, design: .default))
            .foregroundColor(Color(.secondaryLabel))
    }
    
    /// Password & Confirm Password Fields
    private var passwordConfirmPasswordFields: some View {
        VStack(spacing: 3) {
            VStack(spacing: 0) {
                SecureField("Password", text: $password)
                    .textContentType(.newPassword)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(height: 50)
                    .background(
                        Rectangle()
                            .stroke()
                            .foregroundColor(.secondary.opacity(0.3))
                    )
                    .focused($focusField, equals: .password)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .confirmPassword
                    }
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textContentType(.newPassword)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .confirmPassword)
                    .submitLabel(.done)
                    .onSubmit {
                        verifyData()
                        focusField = nil
                    }
            }
            .background(.secondary.opacity(0.1))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(isPasswordConfirmPasswordValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            if !isPasswordConfirmPasswordValid {
                if passwordConfirmPasswordMatch {
                    Text(ErrorMessage.passwordConfirmPasswordInvalid.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: .systemRed))
                } else {
                    Text(ErrorMessage.passwordConfirmPasswordDontMatch.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: .systemRed))
                }
            }
        }
    }
    
    /// Update Password Button
    private var updatePasswordButton: some View {
        Button {
            // VerifyData()
            authenticationViewModel.showForgotPasswordView.toggle()
        } label: {
            HStack {
                Spacer()
                Text("Update Password")
                    .font(.system(size: 24, weight: .medium))
                    .frame(height: 44)
                Spacer()
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(isUpdateButtonDisabled())
    }
}



extension UpdatePasswordView {
    
    /// Verifies the given password and confirm password.
    private func verifyData() {
        if password.isEmpty || confirmPassword.isEmpty {
            isPasswordConfirmPasswordValid = false
        } else if password != confirmPassword {
            passwordConfirmPasswordMatch = false
            isPasswordConfirmPasswordValid = false
        } else {
            passwordConfirmPasswordMatch = true
            isPasswordConfirmPasswordValid = true
        }
    }
    
    /// Let's us know if the Update Button is disabled or not.
    /// Returns true if the update button is disabled.
    private func isUpdateButtonDisabled() -> Bool {
        if password.isEmpty ||
           confirmPassword.isEmpty ||
           password != confirmPassword {
            return true
        }
        return false
    }
}
