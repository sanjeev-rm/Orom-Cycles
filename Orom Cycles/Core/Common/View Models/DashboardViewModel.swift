//
//  DashboardViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import Foundation
import SwiftUI

final class DashboardViewModel: ObservableObject {
    
    /// Variable to show the scannerView
    @Published var showScanner: Bool = false
    @Published var showProfile: Bool = false
    @Published var showWallet: Bool = false
    @Published var showSettings: Bool = false
    
    @Published var showInvalidQRCodeMessage: Bool = false
    
    @Published var showStartRide: Bool = false
    @Published var showRiding: Bool = false
    @Published var showRideCompleted: Bool = false
    
    @Published var showDashboardProgress: Bool = true
    
    func toggleShowScanner() {
        withAnimation(.easeInOut) {
            showScanner = !showScanner
        }
    }
    
    func toggleShowProfile() {
        withAnimation(.easeInOut) {
            showProfile = !showProfile
        }
    }
    
    func toggleShowWallet() {
        withAnimation(.easeInOut) {
            showWallet = !showWallet
        }
    }
    
    func toggleShowSettings() {
        withAnimation(.easeInOut) {
            showSettings = !showSettings
        }
    }
    
    func toggleShowStartRide() {
        withAnimation(.easeInOut) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.showStartRide = !self.showStartRide
            }
        }
    }
    
    func toggleShowRiding() {
        withAnimation(.easeInOut) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.showRiding = !self.showRiding
            }
        }
    }
    
    func toggleShowRideCompleted() {
        withAnimation(.easeInOut) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.showRideCompleted = !self.showRideCompleted
            }
        }
    }
    
    func toggleShowInvalidQRCodeMessage() {
        withAnimation(.easeInOut) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.showInvalidQRCodeMessage = !self.showInvalidQRCodeMessage
            }
        }
    }
    
    func checkForActiveBooking() {
//        withAnimation(.easeInOut) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.showDashboardProgress = true
//            }
//        }
        self.showDashboardProgress = true
        DashboardAPIService().getActiveBooking { result in
            DispatchQueue.main.async {
                self.showDashboardProgress = false
            }
            switch result {
            case .success(_):
                self.toggleShowRiding()
            case .failure(let error):
                switch error {
                case .noInternetConnection:
                    print("DEBUG: " + error.localizedDescription)
                case .custom(let message):
                    print("DEBUG: " + message)
                }
            }
        }
    }
}
