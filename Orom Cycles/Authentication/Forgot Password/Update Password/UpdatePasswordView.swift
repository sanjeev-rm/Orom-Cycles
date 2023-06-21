//
//  UpdatePasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI

struct UpdatePasswordView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var updatePasswordViewModel = ViewModel()
    
    @FocusState private var focusField: FocusField?
    
    private enum FocusField {
        case password
        case confirmPassword
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



// MARK: - View Components

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
                SecureField("Password", text: $updatePasswordViewModel.password)
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
                
                SecureField("Confirm Password", text: $updatePasswordViewModel.confirmPassword)
                    .textContentType(.newPassword)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .confirmPassword)
                    .submitLabel(.done)
                    .onSubmit {
                        updatePasswordViewModel.verifyPasswordConfirmPassword()
                        focusField = nil
                    }
            }
            .background(.secondary.opacity(0.1))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(updatePasswordViewModel.isPasswordConfirmPasswordValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            if !updatePasswordViewModel.isPasswordConfirmPasswordValid {
                Text(updatePasswordViewModel.passwordErrorMessage.rawValue)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(uiColor: .systemRed))
            }
        }
    }
    
    /// Update Password Button
    private var updatePasswordButton: some View {
        Button {
            // VerifyData()
            updatePasswordViewModel.isPasswordUpdating = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                authenticationViewModel.showForgotPasswordView = false
                authenticationViewModel.presentUpdatedPasswordAlert()
            }
        } label: {
            HStack {
                Spacer()
                Text(updatePasswordViewModel.isPasswordUpdating ? "Updating Password ..." : "Update Password")
                    .font(.system(size: 24, weight: .medium))
                    .frame(height: 44)
                Spacer()
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(updatePasswordViewModel.isUpdateButtonDisabled() || updatePasswordViewModel.isPasswordUpdating)
    }
}
