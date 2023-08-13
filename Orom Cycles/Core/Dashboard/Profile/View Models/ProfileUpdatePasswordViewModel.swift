//
//  ProfileUpdatePasswordViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/08/23.
//

import Foundation
import SwiftUI

extension ProfileUpdatePasswordView {
    
    @MainActor
    final class ProfileUpdatePasswordViewModel: ObservableObject {
        
        @Published var currentPassword: String = ""
        @Published var newPassword: String = ""
        @Published var confirmNewPassword: String = ""
        
        @Published var currentPasswordValidity: ValidityAndError<PasswordError> = .init(isValid: true, error: .wrongCurrentPassword)
        @Published var newPasswordValidity: ValidityAndError<PasswordError> = .init(isValid: true, error: .passwordsDontMatch)
        
        @Published var showProgress: Bool = false
        
        enum PasswordError: Error {
            case passwordsDontMatch
            case wrongCurrentPassword
            
            var message: String {
                switch self {
                case .passwordsDontMatch: return "Password don't match"
                case .wrongCurrentPassword: return "Wrong password"
                }
            }
        }
        
        func checkAllPasswords() -> Bool {
            return currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty || newPassword != confirmNewPassword
        }
        
        func checkNewPasswords() {
            if newPassword != confirmNewPassword {
                newPasswordValidity.setInvalid(withError: .passwordsDontMatch)
            } else {
                newPasswordValidity.setValid()
            }
        }
        
        func toggleShowProgress() {
            withAnimation(.easeInOut) {
                showProgress = !showProgress
            }
        }
        
        func updatePassword(completion: @escaping (Bool) -> Void) {
            toggleShowProgress()
            
            DashboardAPIService().updatePassword(passwordCurrent: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { [unowned self] result in
                DispatchQueue.main.async {
                    self.toggleShowProgress()
                    switch result {
                    case .success(let jwt):
                        Storage.jsonWebToken = jwt
                        completion(true)
                    case .failure(let error):
                        switch error {
                        case .noInternetConnection:
                            print("No Internet Connection")
                        case .custom(let message):
                            self.currentPasswordValidity.setInvalid(withError: .wrongCurrentPassword)
                            print(message)
                        }
                        completion(false)
                    }
                }
            }
        }
    }
}
