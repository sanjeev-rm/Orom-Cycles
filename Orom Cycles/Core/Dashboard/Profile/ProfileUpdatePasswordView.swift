//
//  ProfileUpdatePasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/08/23.
//

import SwiftUI

struct ProfileUpdatePasswordView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @StateObject var profileUpdatePasswordViewModel = ProfileUpdatePasswordViewModel()
    
    @FocusState var focusField: FocusField?
    enum FocusField {
        case currentPassword
        case newPassword
        case confirmNewPassword
    }
    
    var body: some View {
        VStack(spacing: 16) {
            doneButton
            VStack(spacing: 32) {
                title
                textFields
            }
            Spacer()
        }
        .padding()
    }
}



extension ProfileUpdatePasswordView {
    
    private var doneButton: some View {
        HStack {
            Button("Cancel") {
                // Dismiss View
                profileViewModel.toggleShowUpdatePasswordSheet()
            }
            .disabled(profileUpdatePasswordViewModel.showProgress)
            
            Spacer()
            
            if profileUpdatePasswordViewModel.showProgress {
                ProgressView()
            } else {
                Button("Done") {
                    // Update Name
                    profileUpdatePasswordViewModel.updatePassword { success in
                        if success {
                            profileViewModel.toggleShowUpdatePasswordSheet()
                        }
                    }
                }
                .disabled(profileUpdatePasswordViewModel.checkAllPasswords())
            }
        }
    }
    
    private var title: some View {
        HStack {
            Text("Update Password")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    private var textFields: some View {
        VStack(spacing: 16) {
            currentPasswordTextFieldWithErrorHandling
            newAndConfirmPasswordTextFieldsWithErrorHandling
        }
    }
    
    private var currentPasswordTextFieldWithErrorHandling: some View {
        VStack {
            currentPasswordTextField
            if !profileUpdatePasswordViewModel.currentPasswordValidity.isValid {
                Text(profileUpdatePasswordViewModel.currentPasswordValidity.error.message)
                    .foregroundColor(Color(.systemRed))
                    .font(.caption)
            }
        }
    }
    
    private var currentPasswordTextField: some View {
        SecureField("Current Password", text: $profileUpdatePasswordViewModel.currentPassword)
            .textContentType(.password)
            .focused($focusField, equals: .currentPassword)
            .submitLabel(.next)
            .onSubmit {
                focusField = .newPassword
            }
            .padding()
            .frame(height: 50)
            .background(Color(oromColor: .textFieldBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 3)
                    .foregroundColor(profileUpdatePasswordViewModel.currentPasswordValidity.isValid ? .clear : Color(.systemRed))
            )
    }
    
    private var newAndConfirmPasswordTextFieldsWithErrorHandling: some View {
        VStack {
            newAndConfirmPasswordTextFields
            if !profileUpdatePasswordViewModel.newPasswordValidity.isValid {
                Text(profileUpdatePasswordViewModel.newPasswordValidity.error.message)
                    .foregroundColor(Color(.systemRed))
                    .font(.caption)
            }
        }
    }
    
    private var newAndConfirmPasswordTextFields: some View {
        VStack(spacing: 8) {
            SecureField("New Password", text: $profileUpdatePasswordViewModel.newPassword)
                .textContentType(.newPassword)
                .focused($focusField, equals: .newPassword)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .confirmNewPassword
                }
                .padding([.horizontal, .top])
            
            Divider()
                .padding(.horizontal)
                .padding(.vertical, 8)
            
            SecureField("Confirm New Password", text: $profileUpdatePasswordViewModel.confirmNewPassword)
                .textContentType(.newPassword)
                .focused($focusField, equals: .confirmNewPassword)
                .submitLabel(.done)
                .onSubmit {
                    focusField = nil
                    // Call the Update Password API
                }
                .onChange(of: profileUpdatePasswordViewModel.confirmNewPassword, perform: { _ in
                    profileUpdatePasswordViewModel.checkNewPasswords()
                })
                .padding([.horizontal, .bottom])
        }
        .background(Color(oromColor: .textFieldBackground))
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 3)
                .foregroundColor(profileUpdatePasswordViewModel.newPasswordValidity.isValid ? .clear : Color(.systemRed))
        )
    }
}

struct ProfileUpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdatePasswordView()
            .environmentObject(ProfileViewModel())
    }
}
