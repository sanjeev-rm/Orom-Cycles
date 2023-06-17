//
//  LoginView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @ObservedObject var loginViewModel: ViewModel = ViewModel()
    
    /// Variable that sets which field is in focus.
    /// Helps with functionalities of the keyboard.
    @FocusState private var focusField: FocusField?
    
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
            loginViewModel.onDismissFullScreenCover()
        }, content: {
            OnboardingView()
        })
        .fullScreenCover(isPresented: $authenticationViewModel.showForgotPasswordView, onDismiss: {
            loginViewModel.onDismissFullScreenCover()
        }, content: {
            ForgotPasswordView()
        })
        .fullScreenCover(isPresented: $authenticationViewModel.showSignupView, onDismiss: {
            loginViewModel.onDismissFullScreenCover()
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



// MARK: - View Components

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
                TextField("Vit Email Address", text: $loginViewModel.email)
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
                
                SecureField("Password", text: $loginViewModel.password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit {
                        focusField = nil
                        loginViewModel.verifyUser()
                    }
            }
            .background(.secondary.opacity(0.1))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(loginViewModel.isUserValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            // If the user is invalid then invalid message is shown.
            if !loginViewModel.isUserValid {
                Text(loginViewModel.errorMessage.rawValue)
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
                loginViewModel.verifyUser()
                if loginViewModel.isUserValid {
                    authenticationViewModel.isLoggedIn.toggle()
                }
            } label: {
                Image(systemName: "arrow.forward.circle")
                    .font(.system(size: 36))
                    .foregroundColor(.accentColor)
            }
            .disabled(loginViewModel.isLoginButtonDisabled())
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
