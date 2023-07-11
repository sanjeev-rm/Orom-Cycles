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
    
    @StateObject var signupViewModel = ViewModel()
    
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
                            scrollableBaseView
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
                            scrollableBaseView
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
        .toast(isPresenting: $signupViewModel.alert.showAlert, duration: 8.0, tapToDismiss: true) {
            return OromAlert.getAlertToast(with: signupViewModel.alert.message, signupViewModel.alert.alertType)
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
    
    /// The view that needs to be scrollable
    /// Other components of the view except title and subtitle
    private var scrollableBaseView: some View {
        VStack(spacing: 16) {
            nameAndEmailFields
            
            passwordAndConfirmPasswordFields
            
            signUpButton
            
            seperatorLine
            
            loginButton
        }
        .padding(8)
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
                    .focused($focusField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .email
                    }
                
                Divider().padding([.leading, .trailing], 8)
                
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
            .background(Color(oromColor: .textFieldBackground))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(signupViewModel.nameEmailValidity.isValid ? Color.clear : Color(UIColor.systemRed))
            )
            .shadow(color: Color(oromColor: .shadowColor), radius: (focusField == .name || focusField == .email) ? 3 : 0)
            
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
                    .focused($focusField, equals: .password)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .confirmPassword
                    }
                
                Divider().padding([.leading, .trailing], 8)
                
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
            .background(Color(oromColor: .textFieldBackground))
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(signupViewModel.passwordConfirmPasswordErrorValidity.isValid ? Color.clear : Color(UIColor.systemRed))
            )
            .shadow(color: Color(oromColor: .shadowColor), radius: (focusField == .password || focusField == .confirmPassword) ? 3 : 0)
            
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
                .foregroundColor(Color(oromColor: .labelPrimary))
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
                        .foregroundColor(Color(oromColor: .labelPrimary))
                    Text("Login")
                        .foregroundColor(.accentColor)
                        .underline()
                }
            }
            .disabled(signupViewModel.showProgressView)
            Spacer()
        }
        .font(.system(size: 14))
    }
}
