//
//  LoginView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    /// Variable that sets which field is in focus.
    /// Helps with functionalities of the keyboard.
    @FocusState private var focusField: FocusField?
    
    /// Variable that shows whether the given data is valid or not.
    @State var isDataValid: Bool = true
    
    /// Different fields in this view.
    private enum FocusField {
        case email
        case password
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleAndSubtitle
                .padding(.top, 8)
            
            Spacer()
            
            emailAndPasswordFields
            
            loginButton
            
            seperatorLine
            
            forgotPasswordAndSignUpButtons
                .padding(.top, 16)
            
            Spacer()
            Spacer()
        }
        .padding(32)
        .fullScreenCover(isPresented: $authenticationViewModel.showOnboardingView, onDismiss: {
            onDismissFullScreenCover()
        }, content: {
            OnboardingView()
        })
        .fullScreenCover(isPresented: $authenticationViewModel.showForgotPasswordView, onDismiss: {
            onDismissFullScreenCover()
        }, content: {
            ForgotPasswordView()
        })
        .fullScreenCover(isPresented: $authenticationViewModel.showSignupView, onDismiss: {
            onDismissFullScreenCover()
        }, content: {
            SignUpView()
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



extension LoginView {
    
    /// The Title & Subtitle View
    private var titleAndSubtitle: some View {
        VStack(alignment: .leading) {
            Text("Hello Again!")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.accentColor)
            Text("Welcome Back")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(.secondaryLabel))
        }
    }
    
    /// Email & Password TextFields
    private var emailAndPasswordFields: some View {
        VStack {
            VStack(spacing: 0) {
                TextField("Vit Email Address", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .padding(16)
                    .frame(height: 50)
                    .background(
                        Rectangle()
                            .stroke()
                            .foregroundColor(.secondary.opacity(0.3))
                    )
                    .focused($focusField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .password
                    }
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit {
                        focusField = nil
                        verifyData()
                    }
            }
            .background(.secondary.opacity(0.1))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(isDataValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            // If the Given data is invalid then invalid message is shown.
            if !isDataValid {
                Text("Invalid Username / Password")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(UIColor.systemRed))
            }
        }
    }
    
    /// Login Button
    private var loginButton: some View {
        HStack {
            Text("Login")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            
            Button {
                verifyData()
                if isDataValid {
                    authenticationViewModel.isLoggedIn.toggle()
                }
            } label: {
                Image(systemName: "arrow.forward.circle")
                    .font(.system(size: 36))
                    .foregroundColor(.accentColor)
            }
            .disabled(isLoginButtonDisabled())
        }
    }
    
    /// Seperator Line
    private var seperatorLine: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray.opacity(0.5))
    }
    
    /// Forgot Password & Sign Up buttons
    private var forgotPasswordAndSignUpButtons: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Button {
                    authenticationViewModel.showForgotPasswordView.toggle()
                } label: {
                    Text("Forgot Password ?")
                        .foregroundColor(.accentColor)
                        .underline()
                }
                
                Button {
                    authenticationViewModel.showSignupView.toggle()
                } label: {
                    HStack {
                        Text("First time? ")
                            .foregroundColor(.primary)
                        Text("Sign Up")
                            .foregroundColor(.accentColor)
                            .underline()
                    }
                }
            }
            .font(.system(size: 14))
            Spacer()
        }
    }
}



extension LoginView {
    
    /// Function verifies the email and password entered by the user.
    private func verifyData() {
        if email.isEmpty || password.isEmpty {
            isDataValid = false
        } else {
            // Send to API and verify user.
            isDataValid = true
        }
    }
    
    /// Function that does everything that needs to be done when the fullScreen cover dismisses.
    private func onDismissFullScreenCover() {
        isDataValid = true
        email = ""
        password = ""
    }
    
    private func isLoginButtonDisabled() -> Bool {
        return email.isEmpty || password.isEmpty
    }
}
