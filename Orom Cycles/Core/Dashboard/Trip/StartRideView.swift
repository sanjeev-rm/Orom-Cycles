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
            } else if tripViewModel.showInsufficientFundsError || tripViewModel.showUnableToStartRideError {
                VStack(alignment:.leading, spacing: 3) {
                    Text(tripViewModel.showInsufficientFundsError ? "Insufficient funds." : "Unable to start ride.")
                    Text(tripViewModel.showInsufficientFundsError ? "To start ride you need a minimum balance of ₹10." : "Try again later.")
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color(.systemRed))
            }
            
            Spacer()
            
            VStack {
                
                Text("An minimum amount of ₹10 will be charged for the ride")
                    .foregroundStyle(.secondary)
                    .font(.caption2.weight(.light))
                
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
        .onAppear(perform: {
            tripViewModel.setToDefault()
        })
    }
}

struct StartRideView_Previews: PreviewProvider {
    static var previews: some View {
        StartRideView()
            .environmentObject(DashboardViewModel())
            .environmentObject(TripViewModel())
    }
}
