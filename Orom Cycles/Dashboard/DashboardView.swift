//
//  VerificationView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        MapView()
            .fullScreenCover(isPresented: $dashboardViewModel.showScanner) {
                ScannerView()
            }
            .fullScreenCover(isPresented: $dashboardViewModel.showProfile) {
                ProfileView()
            }
            .fullScreenCover(isPresented: $dashboardViewModel.showWallet) {
                WalletView()
            }
            .fullScreenCover(isPresented: $dashboardViewModel.showSettings) {
                SettingsView()
            }
            .sheet(isPresented: $dashboardViewModel.showStartRide) {
                if #available(iOS 16.0, *) {
                    StartRideView()
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                } else {
                    StartRideView()
                        .interactiveDismissDisabled()
                }
            }
            .sheet(isPresented: $dashboardViewModel.showRiding) {
                if #available(iOS 16.0, *) {
                    RidingView()
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                } else {
                    RidingView()
                        .interactiveDismissDisabled()
                }
            }
            .sheet(isPresented: $dashboardViewModel.showRideCompleted) {
                if #available(iOS 16.0, *) {
                    CompletedRideView()
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                } else {
                    CompletedRideView()
                        .interactiveDismissDisabled()
                }
            }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
