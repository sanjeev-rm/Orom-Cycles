//
//  SignUpView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI
import AlertToast

struct SignUpView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @ObservedObject var signupViewModel = ViewModel()
    
    /// Variable that sets which field is in focus
    /// Helps with functionalities of the keyboard
    @FocusState private var focusField: FocusField?
    
    /// Different fields in this view
    private enum FocusField {
        case name
        case email
        case password
        case confirmPassword
    }
    
    var body: some View {
        VStack {
            // .scrollIndicators(), .scrollDisabled(), etc is only onwoards iOS 16.0.
            if #available(iOS 16.0, *) {
                NavigationStack {
                    VStack(alignment: .leading, spacing: 32) {
                        titleAndSubtitle
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 16) {
                                nameAndEmailFields
                                
                                passwordAndConfirmPasswordFields
                                
                                signUpButton
                                
                                seperatorLine
                                
                                loginButton
                            }
                            .padding(8)
                        }
                        .scrollIndicators(.hidden)
                        .scrollDisabled(focusField == nil)
                        .scrollDismissesKeyboard(.interactively)
                    }
                    .padding(24)
                    .navigationDestination(isPresented: $signupViewModel.navigateToVerification) {
                        SignUpVerifyOTPView()
                    }
                }
            } else {
                // Fallback on earlier versions
                NavigationView {
                    VStack(alignment: .leading, spacing: 16) {
                        titleAndSubtitle
                        
                        ScrollView(focusField == nil ? [] : .vertical, showsIndicators: false) {
                            VStack(spacing: 16) {
                                nameAndEmailFields
                                
                                passwordAndConfirmPasswordFields
                                
                                signUpButton
                                
                                seperatorLine
                                
                                loginButton
                            }
                            .padding(8)
                        }
                    }
                    .padding(24)
                    .navigationBarHidden(true)
                    .background(
                        Group {
                            NavigationLink(destination: SignUpVerifyOTPView(),
                                           isActive: $signupViewModel.navigateToVerification) {
                                EmptyView()
                            }
                        }
                    )
                }
            }
        }
        .toast(isPresenting: $signupViewModel.showAlert, duration: 10.0, tapToDismiss: true) {
            let alertType: AlertToast.AlertType
            switch signupViewModel.alertType {
            case .basic: alertType = .regular
            case .success: alertType = .complete(Color(uiColor: .systemGreen))
            case .failure: alertType = .error(Color(uiColor: .systemRed))
            case .warning: alertType = .systemImage("exclamationmark.triangle.fill", Color(uiColor: .systemYellow))
            }
            return AlertToast(displayMode: .hud,
                              type: alertType,
                              subTitle: signupViewModel.alertMessage)
        }
    }
}
    

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}



// MARK: - View Components

extension SignUpView {
    
    /// The title And Subtitle View
    private var titleAndSubtitle: some View {
        VStack(alignment: .leading) {
            Text("Hello")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.accentColor)
            Text("Get Started")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(.secondaryLabel))
        }
    }
    
    /// Name & Email TextFields
    private var nameAndEmailFields: some View {
        VStack {
            VStack(spacing: 0) {
                TextField("Name", text: $signupViewModel.name)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .padding(16)
                    .frame(height: 50)
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
                
                TextField("Vit Email Address", text: $signupViewModel.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        signupViewModel.checkNameEmail()
                        focusField = .password
                    }
            }
            .background(.secondary.opacity(0.1))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(signupViewModel.nameEmailValidity.isValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            if !signupViewModel.nameEmailValidity.isValid {
                Text(signupViewModel.nameEmailValidity.error.message)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(uiColor: .systemRed))
            }
        }
    }
    
    /// Password & Confirm Password TextFields
    private var passwordAndConfirmPasswordFields: some View {
        VStack {
            VStack(spacing: 0) {
                SecureField("Password", text: $signupViewModel.password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
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
                
                SecureField("Confirm Password", text: $signupViewModel.confirmPassword)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .padding(16)
                    .frame(height: 50)
                    .focused($focusField, equals: .confirmPassword)
                    .submitLabel(.done)
                    .onSubmit {
                        signupViewModel.checkUserData()
                        focusField = nil
                    }
            }
            .background(.secondary.opacity(0.1))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(signupViewModel.passwordConfirmPasswordErrorValidity.isValid ? Color.secondary.opacity(0.3) : Color(UIColor.systemRed).opacity(0.3))
            )
            
            if !signupViewModel.passwordConfirmPasswordErrorValidity.isValid {
                Text(signupViewModel.passwordConfirmPasswordErrorValidity.error.message)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(uiColor: .systemRed))
            }
        }
    }
    
    /// SignUp Button
    private var signUpButton: some View {
        HStack {
            Text("Sign Up")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            
            if signupViewModel.showProgressView {
                ProgressView()
                    .controlSize(.large)
                    .tint(.accentColor)
            } else {
                Button {
                    signupViewModel.signUp()
                } label: {
                    Image(systemName: "arrow.forward.circle")
                        .font(.system(size: 36))
                        .foregroundColor(.accentColor)
                }
                .disabled(signupViewModel.isVerifyButtonDisabled())
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
            Spacer()
            Button {
                authenticationViewModel.showSignupView = false
            } label: {
                HStack {
                    Text("Visiting Again?")
                        .foregroundColor(.primary)
                    Text("Login")
                        .foregroundColor(.accentColor)
                        .underline()
                }
            }
            Spacer()
        }
        .font(.system(size: 14))
    }
}
