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
                if #available(iOS 16.0, *) {
                    StartRideView()
                        .environmentObject(tripViewModel)
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                } else {
                    StartRideView()
                        .environmentObject(tripViewModel)
                        .interactiveDismissDisabled()
                }
            }
            .sheet(isPresented: $dashboardViewModel.showRiding) {
                if #available(iOS 16.0, *) {
                    RidingView()
                        .environmentObject(tripViewModel)
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                } else {
                    RidingView()
                        .environmentObject(tripViewModel)
                        .interactiveDismissDisabled()
                }
            }
            .sheet(isPresented: $dashboardViewModel.showRideCompleted) {
                if #available(iOS 16.0, *) {
                    CompletedRideView()
                        .environmentObject(tripViewModel)
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                } else {
                    CompletedRideView()
                        .environmentObject(tripViewModel)
                        .interactiveDismissDisabled()
                }
            }
    }
}

struct DashboardRootView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardBaseView()
    }
}
