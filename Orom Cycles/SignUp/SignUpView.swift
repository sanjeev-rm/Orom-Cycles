//
//  SignUpView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

// MARK: - PROBLEM --> Verification of data before going to Verify OTP page.

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @Binding var isPresenting: Bool
    
    /// Variable that sets which field is in focus
    /// Helps with functionalities of the keyboard
    @FocusState private var focusField: FocusField?
    
    /// Variable that shows whether the Name & Email is valid or not
    @State private var isNameEmailValid: Bool = true
    
    /// Variable that shows whether the Password & Confirm Password is valid or not
    @State private var isPasswordConfirmPasswordValid: Bool = true
    /// Variable that shows whether the Password & Confirm Password match
    @State private var passwordConfirmPasswordMatch: Bool = true
    
    @State private var isAllDataValid: Bool = false
    
    /// Different fields in this view
    private enum FocusField {
        case name
        case email
        case password
        case confirmPassword
    }
    
    var body: some View {
        NavigationView {
            // This is done to use the .toolbar() function.
            // To remove extra space in the top.
            // .toolbar() is only onwoards iOS 16.0.
            if #available(iOS 16.0, *) {
                VStack(alignment: .leading, spacing: 16) {
                    titleAndSubtitle
                    
                    Spacer()
                    
                    nameAndEmailFields
                    
                    passwordAndConfirmPasswordFields
                    
                    verifyButton
                    
                    seperatorLine
                    
                    loginButton
                    
                    Spacer()
                    Spacer()
                }
                .padding(32)
                .navigationTitle("")
                .toolbar(.hidden)
            } else {
                // Fallback on earlier versions
                VStack(alignment: .leading, spacing: 16) {
                    titleAndSubtitle
                    
                    Spacer()
                    
                    nameAndEmailFields
                    
                    passwordAndConfirmPasswordFields
                    
                    verifyButton
                    
                    seperatorLine
                    
                    loginButton
                    
                    Spacer()
                    Spacer()
                }
                .padding(32)
                .navigationBarHidden(true)
            }
        }
    }
}
    

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isPresenting: .constant(true))
    }
}



extension SignUpView {
    
    /// The title And Subtitle View
    private var titleAndSubtitle: some View {
        VStack(alignment: .leading) {
            Text("Hello")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.accentColor)
            Text("Get Started")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.gray)
        }
    }
    
    /// Name & Email TextFields
    private var nameAndEmailFields: some View {
        VStack {
            VStack(spacing: 0) {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    .background(
                        Rectangle()
                            .stroke()
                            .foregroundColor(.secondary.opacity(0.3))
                    )
                    .focused($focusField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .email
                    }
                
                TextField("Vit Email Address", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    .focused($focusField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        verifyNameAndEmail()
                        focusField = .password
                    }
            }
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
                    .foregroundColor(isNameEmailValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            if !isNameEmailValid {
                Text("Invalid Name / Email")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(uiColor: .systemRed))
            }
        }
    }
    
    /// Password & Confirm Password TextFields
    private var passwordAndConfirmPasswordFields: some View {
        VStack {
            VStack(spacing: 0) {
                SecureField("Password", text: $password)
                    .textContentType(.newPassword)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.width - 64, height: 50)
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
                    .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    .focused($focusField, equals: .confirmPassword)
                    .submitLabel(.done)
                    .onSubmit {
                        verifyData()
                        focusField = nil
                    }
            }
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
                    .foregroundColor(isPasswordConfirmPasswordValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            if !isPasswordConfirmPasswordValid {
                if !passwordConfirmPasswordMatch {
                    Text("Password & Confirm Password don't match")
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: .systemRed))
                } else {
                    Text("Invalid Password & Confirm Password")
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: .systemRed))
                }
            }
        }
    }
    
    /// Verify Button
    private var verifyButton: some View {
        HStack {
            Text("Verify")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            
            NavigationLink {
                if isNameEmailValid && isPasswordConfirmPasswordValid {
                    VerifyOTPView()
                }
            } label: {
                Image(systemName: "arrow.forward.circle")
                    .font(.system(size: 36))
                    .foregroundColor(.accentColor)
            }
            .disabled(!isAllDataValid)
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
        Button {
            isPresenting.toggle()
        } label: {
            HStack {
                Spacer()
                HStack {
                    Text("First time?")
                    Text("Login")
                        .foregroundColor(.accentColor)
                        .underline()
                }
                Spacer()
            }
        }
    }
}

extension SignUpView {
    
    /// Function verifies data entered by the user
    private func verifyData() {
        verifyNameAndEmail()
        verifyPasswordAndConfirmPassword()
        isAllDataValid = isNameEmailValid && isPasswordConfirmPasswordValid
    }
    
    /// Function verifies Name & Email
    private func verifyNameAndEmail() {
        if name.isEmpty, email.isEmpty {
            isNameEmailValid = false
        } else {
            isNameEmailValid = true
        }
    }
    
    /// Function verifies Password & Confirm Password
    private func verifyPasswordAndConfirmPassword() {
        if password.isEmpty, confirmPassword.isEmpty {
            isPasswordConfirmPasswordValid = false
        } else if !(password == confirmPassword) {
            passwordConfirmPasswordMatch = (password == confirmPassword)
            isPasswordConfirmPasswordValid = false
        } else {
            isPasswordConfirmPasswordValid = true
            passwordConfirmPasswordMatch = true
        }
    }
}
