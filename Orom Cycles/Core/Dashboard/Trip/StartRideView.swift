//
//  StartRideView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/07/23.
//

import SwiftUI

struct StartRideView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            VStack(alignment: .leading, spacing: 16) {
                Text(tripViewModel.cycleName)
                    .foregroundColor(.primary.opacity(0.8))
                    .font(.system(size: 44, weight: .bold))
                
                Text("Start Ride to unlock the cycle and begin trip")
                    .foregroundColor(.secondary)
                    .font(.system(size: 16, weight: .light))
            }
            
            if tripViewModel.startRideViewShowProgress {
                ProgressView()
            }
            
            Spacer()
            
            VStack {
                
                Button {
                    // Start Ride
                    tripViewModel.startRideWithCycle { success in
                        if success {
                            // Dismiss Start Ride View
                            dashboardViewModel.toggleShowStartRide()
                            // Show Riding View
                            dashboardViewModel.toggleShowRiding()
                        }
                    }
                } label: {
                    HStack {
                        Text(tripViewModel.startRideViewShowProgress ? "Unlocking Your Cycle..." : "Start Ride")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(16)
                    }
                }
                
                Button {
                    // Cancel
                    // Dismiss view
                    dashboardViewModel.toggleShowStartRide()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(uiColor: .systemRed).opacity(0.8))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(16)
                }
            }
            .disabled(tripViewModel.startRideViewShowProgress)
        }
        .padding(.top, 44)
        .padding()
    }
}

struct StartRideView_Previews: PreviewProvider {
    static var previews: some View {
        StartRideView()
    }
}
