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
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @StateObject var tripViewModel: TripViewModel = TripViewModel()
    
    var body: some View {
        DashboardBaseView()
            .disabled(dashboardViewModel.showDashboardProgress)
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
            .sheet(isPresented: $dashboardViewModel.showDashboardProgress) {
                SheetAlertView(.progress)
                    .presentationDetents([.height(175)])
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $networkMonitor.isNotConnected) {
                SheetAlertView(.networkIssue)
                    .presentationDetents([.height(175)])
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $dashboardViewModel.showInvalidQRCodeMessage) {
                SheetAlertView(.other, imageSystemName: "qrcode.viewfinder", text: "Invalid QR code")
                    .presentationDetents([.height(175)])
            }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DashboardViewModel())
            .environmentObject(NetworkMonitor())
    }
}
