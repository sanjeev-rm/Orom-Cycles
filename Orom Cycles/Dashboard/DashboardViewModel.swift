//
//  DashboardViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import Foundation
import SwiftUI

final class DashboardViewModel: ObservableObject {
    
    @Published var showScanner: Bool = false
    @Published var showProfile: Bool = false
    @Published var showWallet: Bool = false
    @Published var showSettings: Bool = false
    
    @Published var showStartRide: Bool = false
    @Published var showRiding: Bool = false
    @Published var showRideCompleted: Bool = false
    
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showStartRide = !self.showStartRide
            }
        }
    }
    
    func toggleShowRiding() {
        withAnimation(.easeInOut) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showRiding = !self.showRiding
            }
        }
    }
    
    func toggleShowRideCompleted() {
        withAnimation(.easeInOut) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showRideCompleted = !self.showRideCompleted
            }
        }
    }
}
