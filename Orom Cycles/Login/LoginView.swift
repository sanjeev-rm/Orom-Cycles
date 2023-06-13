//
//  LoginView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct LoginView: View {
    
    /// Variable responsible for showing the Onboarding Screen.
    @State var showOnboardingView: Bool = true
    /// Variable responsible for showing Sign Up page.
    @State var showSignupView: Bool = false
    /// Variable rerponsible for showing Forgot Password Screen.
    @State var showForgotPasswordView: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    /// Variable that sets which field is in focus.
    /// Helps with functionalities of the keyboard.
    @FocusState private var focusField: FocusField?
    
    /// Variable once true takes the user to the dashboard.
    @Binding var isLoggedIn: Bool
    
    /// Different fields in this view.
    private enum FocusField {
        case email
        case password
    }
    
    /// Variable that shows whether the given data is valid or not.
    @State var isDataValid: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleAndSubtitle
            
            Spacer()
            
            emailAndPasswordFields
            
            loginButton
            
            seperatorLine
            
            HStack {
                Spacer()
                forgotPasswordAndSignUpButtons
                    .padding(.top, 16)
                Spacer()
            }
            
            Spacer()
            Spacer()
        }
        .padding(32)
        .fullScreenCover(isPresented: $showOnboardingView, onDismiss: {
            onDismissFullScreenCover()
        }, content: {
            OnboardingView(isPresenting: $showOnboardingView)
        })
        .fullScreenCover(isPresented: $showForgotPasswordView, onDismiss: {
            onDismissFullScreenCover()
        }, content: {
            ForgotPasswordView(isPresenting: $showForgotPasswordView)
        })
        .fullScreenCover(isPresented: $showSignupView, onDismiss: {
            onDismissFullScreenCover()
        }, content: {
            SignUpView(isPresenting: $showSignupView)
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}



extension LoginView {
    
    /// Email and Password TextFields.
    private var emailAndPasswordFields: some View {
        VStack {
            VStack(spacing: 0) {
                TextField("Vit Email Address", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.width - 64, height: 50)
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
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .padding(16)
                    .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                    .focused($focusField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit {
                        focusField = nil
                        verifyData()
                    }
            }
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
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
    
    /// Login Button.
    private var loginButton: some View {
        HStack {
            Text("Login")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            
            Button {
                verifyData()
                if isDataValid {
                    isLoggedIn.toggle()
                }
            } label: {
                Image(systemName: "arrow.forward.circle")
                    .font(.system(size: 36))
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    /// Seperator Line.
    private var seperatorLine: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray.opacity(0.5))
    }
    
    /// Forgot Password & Sign Up buttons.
    private var forgotPasswordAndSignUpButtons: some View {
        VStack(spacing: 16) {
            Button {
                showForgotPasswordView.toggle()
            } label: {
                Text("Forgot Password ?")
                    .foregroundColor(.accentColor)
                    .underline()
            }
            
            Button {
                showSignupView.toggle()
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
    }
    
    /// The title And Subtitle View.
    private var titleAndSubtitle: some View {
        VStack(alignment: .leading) {
            Text("Hello Again!")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.accentColor)
            Text("Welcome Back")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.gray)
        }
    }
}



extension LoginView {
    
    /// Function verifys the email and password entered by the user.
    private func verifyData() {
        if email.isEmpty || password.isEmpty {
            isDataValid = false
        } else {
            isDataValid = true
        }
    }
    
    /// Function that does everything that needs to be done when the fullScreen cover dismisses.
    private func onDismissFullScreenCover() {
        isDataValid = true
        email = ""
        password = ""
    }
}
