//
//  StartRideView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/07/23.
//

import SwiftUI

struct StartRideView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Cycle 8")
                .foregroundColor(.primary.opacity(0.8))
                .font(.title)
            
            HStack {
                Spacer()
                
                Button {
                    // Start Ride
                    
                    // Dismiss Start Ride View
                    dashboardViewModel.toggleShowStartRide()
                    // Show Riding View
                    dashboardViewModel.toggleShowRiding()
                } label: {
                    Label("Start Ride", systemImage: "checkmark")
                }
                
                Spacer()
                
                Button {
                    // Cancel
                    // Dismiss view
                    dashboardViewModel.toggleShowStartRide()
                } label: {
                    Label("Cancel", systemImage: "xmark")
                        .foregroundColor(Color(uiColor: .systemRed))
                }
                
                Spacer()
            }
        }
    }
}

struct StartRideView_Previews: PreviewProvider {
    static var previews: some View {
        StartRideView()
    }
}
