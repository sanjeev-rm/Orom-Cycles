//
//  ProfileViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 03/08/23.
//

import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published var name: String = "John Doe"
    @Published var email: String = "johndoe@appleseed.com"
    
    @Published var showProgress: Bool = false
    
    @Published var profileError: ValidityAndError<ProfileError> = ValidityAndError(isValid: true, error: .noInternetConnection)
    
    @Published var showUpdateNameSheet: Bool = false
    @Published var showUpdatePasswordSheet: Bool = false
    @Published var showConfirmationForLogOut: Bool = false
    
    @Published var showPasswordUpdated: Bool = false
    
    enum ProfileError: Error {
        case noInternetConnection
        case unableToFetchUserInfo
        case unableToUpdateUserInfo
    }
    
    func toggleShowProgress() {
        withAnimation(.easeInOut) {
            showProgress = !showProgress
        }
    }
    
    func toggleShowUpdateNameSheet() {
        withAnimation(.easeInOut) {
            showUpdateNameSheet = !showUpdateNameSheet
        }
    }
    
    func toggleShowUpdatePasswordSheet() {
        withAnimation(.easeInOut) {
            showUpdatePasswordSheet = !showUpdatePasswordSheet
        }
    }
    
    func toggleShowConfirmationForLogOut() {
        withAnimation(.easeInOut) {
            showConfirmationForLogOut = !showConfirmationForLogOut
        }
    }
    
    func alertUserPasswordHasBeenUpdated() {
        withAnimation(.easeInOut) {
            showPasswordUpdated = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showPasswordUpdated = false
            }
        }
    }
    
    func getUserInfo() {
        showProgress = true
        
        DashboardAPIService().getUserInfo { [unowned self] result in
            DispatchQueue.main.async {
                self.showProgress = false
                switch result {
                case .success(let response):
                    self.name = response.userData.info.name
                    self.email = response.userData.info.email
                case .failure(let error):
                    switch error {
                    case .noInternetConnection:
                        self.profileError.setInvalid(withError: .noInternetConnection)
                        print(error.localizedDescription)
                    case .custom(let message):
                        self.profileError.setInvalid(withError: .unableToFetchUserInfo)
                        print(message)
                    }
                }
            }
        }
    }
    
    func updateName() {
        showProgress = true
        
        DashboardAPIService().updateName(name: name) { result in
            DispatchQueue.main.async {
                self.showProgress = false
                switch result {
                case .success(let response):
                    self.name = response.userData.info.name
                    self.email = response.userData.info.email
                case .failure(let error):
                    switch error {
                    case .noInternetConnection:
                        self.profileError.setInvalid(withError: .noInternetConnection)
                        print(error.localizedDescription)
                    case .custom(let message):
                        self.profileError.setInvalid(withError: .unableToUpdateUserInfo)
                        print(message)
                    }
                }
            }
        }
    }
}
