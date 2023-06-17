//
//  AuthenticationViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 17/06/23.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    /// Variable responsible for showing the Onboarding Screen.
    @Published var showOnboardingView: Bool = true
    /// Variable responsible for showing Sign Up page.
    @Published var showSignupView: Bool = false
    /// Variable rerponsible for showing Forgot Password Screen.
    @Published var showForgotPasswordView: Bool = false
}
