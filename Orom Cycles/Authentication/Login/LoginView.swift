//
//  LoginView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI
import AlertToast

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
            focusField = nil
        }, content: {
            OnboardingView()
        })
        .fullScreenCover(isPresented: $authenticationViewModel.showForgotPasswordView, onDismiss: {
            loginViewModel.onDismissFullScreenCover()
            focusField = nil
        }, content: {
            ForgotPasswordView()
        })
        .fullScreenCover(isPresented: $authenticationViewModel.showSignupView, onDismiss: {
            loginViewModel.onDismissFullScreenCover()
            focusField = nil
        }, content: {
            SignUpView()
        })
        .toast(isPresenting: $loginViewModel.alert.showAlert, duration: 8.0, tapToDismiss: true) {
            let alertType: AlertToast.AlertType
            switch loginViewModel.alert.alertType {
            case .basic: alertType = .regular
            case .success: alertType = .complete(Color(uiColor: .systemGreen))
            case .failure: alertType = .error(Color(uiColor: .systemRed))
            case .warning: alertType = .systemImage("exclamationmark.triangle.fill", Color(uiColor: .systemYellow))
            case .customSystemImage(let systemImage, let color): alertType = .systemImage(systemImage, color)
            case .customImage(let image, let color): alertType = .image(image, color)
            }
            return AlertToast(displayMode: .hud,
                              type: alertType,
                              subTitle: loginViewModel.alert.message)
        }
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
                    .focused($focusField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .password
                    }
                
                Divider().padding([.leading, .trailing], 8)
                
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
                        loginViewModel.checkEmailPassword()
                    }
            }
            .background(Color(oromColor: .textFieldBackground))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(loginViewModel.emailPasswordValidity.isValid ? Color.clear : Color(UIColor.systemRed))
            )
            .shadow(color: Color(oromColor: .shadowColor), radius: (focusField == nil) ? 0 : 3)
            
            // If the user is invalid then invalid message is shown.
            if !loginViewModel.emailPasswordValidity.isValid {
                Text(loginViewModel.emailPasswordValidity.error.message)
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
                .foregroundColor(Color(oromColor: .labelPrimary))
            Spacer()
            
            if loginViewModel.showProgressView {
                ProgressView()
                    .controlSize(.large)
                    .tint(.accentColor)
            } else {
                Button {
                    loginViewModel.login { success in
                        authenticationViewModel.updateLoggedInStatus(success)
                    }
                } label: {
                    Image(systemName: "arrow.forward.circle")
                        .font(.system(size: 36))
                        .foregroundColor(.accentColor)
                }
                .disabled(loginViewModel.isLoginButtonDisabled)
            }
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
                    authenticationViewModel.showForgotPasswordView = true
                } label: {
                    Text("Forgot Password ?")
                        .foregroundColor(.accentColor)
                        .underline()
                }
                
                Button {
                    authenticationViewModel.showSignupView = true
                } label: {
                    HStack {
                        Text("First time? ")
                            .foregroundColor(Color(oromColor: .labelPrimary))
                        Text("Sign Up")
                            .foregroundColor(.accentColor)
                            .underline()
                    }
                }
            }
            .font(.system(size: 14))
            Spacer()
        }
        .disabled(loginViewModel.showProgressView)
    }
}
