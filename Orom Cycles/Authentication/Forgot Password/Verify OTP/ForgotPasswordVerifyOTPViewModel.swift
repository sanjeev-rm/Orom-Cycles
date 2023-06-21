//
//  ForgotPasswordVerifyOTPViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation

extension ForgotPasswordVerifyOTPView {
    @MainActor class ViewModel: ObservableObject {
        @Published var otp: String = "" {
            didSet {
                isNewPasswordButtonDisabled = otp.isEmpty || (otp.count != 6)
            }
        }
        @Published var isNewPasswordButtonDisabled: Bool = true
    }
}