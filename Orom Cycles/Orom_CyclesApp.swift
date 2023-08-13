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
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var walletViewModel = WalletViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.isLoggedIn ?? false {
                DashboardView()
                    .environmentObject(dashboardViewModel)
                    .environmentObject(authenticationViewModel)
                    .environmentObject(profileViewModel)
                    .environmentObject(walletViewModel)
            }
            else {
                AuthenticationView()
                    .environmentObject(authenticationViewModel)
            }
        }
    }
}
