//
//  UpdatePasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/06/23.
//

import SwiftUI
import AlertToast

struct UpdatePasswordView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var updatePasswordViewModel = ViewModel()
    
    @FocusState private var focusField: FocusField?
    
    private enum FocusField {
        case otp
        case password
        case confirmPassword
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            VStack(alignment: .leading, spacing: 8) {
                otpTitle
                
                otpField
            }
            
            VStack(alignment: .leading, spacing: 8) {
                newPasswordTitle
                
                passwordConfirmPasswordFields
            }
            
            updatePasswordButton
            
            Spacer()
        }
        .padding(32)
        .toast(isPresenting: $updatePasswordViewModel.alert.showAlert, duration: 8.0, tapToDismiss: true) {
            return OromAlert.getAlertToast(with: updatePasswordViewModel.alert.message, updatePasswordViewModel.alert.alertType)
        }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}



// MARK: - View Components

extension UpdatePasswordView {
    
    /// Verify Title
    private var otpTitle: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Verify")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(.secondaryLabel))
            
            Text("Enter the OTP sent to your email, Valid for 5 mins")
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(.tertiaryLabel))
        }
    }
    
    /// OTP field
    private var otpField: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 3) {
                TextField("Enter OTP", text: $updatePasswordViewModel.otp)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .otp)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: updatePasswordViewModel.otp) { _ in
                        updatePasswordViewModel.checkOtp()
                    }
                    .background(Color(oromColor: .textFieldBackground))
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke()
                            .foregroundColor(updatePasswordViewModel.otpValidity.isValid ? .clear : Color(.systemRed))
                    )
                    .shadow(color: Color(oromColor: .shadowColor), radius: (focusField == .otp) ? 3 : 0)
                
                if !updatePasswordViewModel.otpValidity.isValid {
                    Text(updatePasswordViewModel.otpValidity.error.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: .systemRed))
                }
            }
        }
    }
    
    /// New Password Title
    private var newPasswordTitle: some View {
        Text("New Password")
            .font(.system(size: 24, weight: .bold, design: .default))
            .foregroundColor(Color(.secondaryLabel))
    }
    
    /// Password & Confirm Password Fields
    private var passwordConfirmPasswordFields: some View {
        VStack(spacing: 3) {
            VStack(spacing: 0) {
                SecureField("Password", text: $updatePasswordViewModel.password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .password)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .confirmPassword
                    }
                
                Divider().padding([.leading, .trailing], 8)
                
                SecureField("Confirm Password", text: $updatePasswordViewModel.confirmPassword)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .confirmPassword)
                    .submitLabel(.done)
                    .onChange(of: updatePasswordViewModel.confirmPassword, perform: { _ in
                        updatePasswordViewModel.checkPasswordConfirmPassword()
                    })
                    .onSubmit {
                        updatePasswordViewModel.checkPasswordConfirmPassword()
                        focusField = nil
                    }
            }
            .background(Color(oromColor: .textFieldBackground))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(updatePasswordViewModel.passwordConfirmPasswordValidity.isValid ? .clear : Color(.systemRed))
            )
            .shadow(color: Color(oromColor: .shadowColor), radius: (focusField == .password || focusField == .confirmPassword) ? 3 : 0)
            
            if !updatePasswordViewModel.passwordConfirmPasswordValidity.isValid {
                Text(updatePasswordViewModel.passwordConfirmPasswordValidity.error.rawValue)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(uiColor: .systemRed))
            }
        }
    }
    
    /// Update Password Button
    private var updatePasswordButton: some View {
        Button {
            // Calling function to update password
            updatePasswordViewModel.updatePassword { hasUpdated in
                if hasUpdated {
                    authenticationViewModel.showForgotPasswordView = false
                    authenticationViewModel.presentUpdatedPasswordAlert()
                }
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
