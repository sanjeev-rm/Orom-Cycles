//
//  DashboardRootView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 03/08/23.
//

import SwiftUI

struct DashboardBaseView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    @StateObject var tripViewModel: TripViewModel = TripViewModel()
    
    var body: some View {
        MapView()
            .fullScreenCover(isPresented: $dashboardViewModel.showScanner) {
                ScannerView()
                    .environmentObject(tripViewModel)
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
                StartRideView()
                    .environmentObject(tripViewModel)
                    .presentationDetents([.medium, .large])
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $dashboardViewModel.showRiding) {
                RidingView()
                    .environmentObject(tripViewModel)
                    .presentationDetents([.medium, .large])
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $dashboardViewModel.showRideCompleted) {
                CompletedRideView()
                    .environmentObject(tripViewModel)
                    .presentationDetents([.medium, .large])
                    .interactiveDismissDisabled()
            }
    }
}

struct DashboardRootView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardBaseView()
            .environmentObject(DashboardViewModel())
    }
}
