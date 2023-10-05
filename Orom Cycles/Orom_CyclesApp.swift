//
//  Orom_CyclesApp.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import SwiftUI

@main
struct Orom_CyclesApp: App {
    
    @ObservedObject var authenticationViewModel = AuthenticationViewModel()
    
    @ObservedObject var dashboardViewModel = DashboardViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var walletViewModel = WalletViewModel()
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.isLoggedIn ?? false {
                DashboardView()
                    .environmentObject(dashboardViewModel)
                    .environmentObject(authenticationViewModel)
                    .environmentObject(profileViewModel)
                    .environmentObject(walletViewModel)
                    .environmentObject(networkMonitor)
            }
            else {
                AuthenticationView()
                    .environmentObject(authenticationViewModel)
            }
//            RazorpayView(razorKey: "rzp_test_aPE8A8hXxdSdZl", amount: "10")
        }
    }
}
