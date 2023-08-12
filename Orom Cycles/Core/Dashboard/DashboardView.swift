//
//  VerificationView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI
import AlertToast

struct DashboardView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    @StateObject var tripViewModel: TripViewModel = TripViewModel()
    
    var body: some View {
        DashboardBaseView()
            .disabled(dashboardViewModel.showDashboardProgress)
            .toast(isPresenting: $dashboardViewModel.showDashboardProgress, duration: 16, tapToDismiss: false) {
                OromAlert.getAlertToast(.loading, displayMode: .alert)
            }
            .onAppear {
                dashboardViewModel.showDashboardProgress = true
                DashboardAPIService().getActiveBooking { result in
                    DispatchQueue.main.async {
                        dashboardViewModel.showDashboardProgress = false
                    }
                    switch result {
                    case .success(_):
                        dashboardViewModel.toggleShowRiding()
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
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DashboardViewModel())
    }
}
