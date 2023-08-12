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
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.isLoggedIn ?? false {
                DashboardView()
                    .environmentObject(dashboardViewModel)
                    .environmentObject(authenticationViewModel)
            }
            else {
                AuthenticationView()
                    .environmentObject(authenticationViewModel)
            }
        }
    }
}
