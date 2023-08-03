//
//  RidingView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/07/23.
//

import SwiftUI

struct RidingView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            Text("Trip Details")
                .foregroundColor(.primary.opacity(0.8))
                .font(.system(size: 44, weight: .bold))
            
            List {
                HStack {
                    Text("Dist (Km)")
                        .foregroundColor(.primary.opacity(0.7))
                        .font(.system(size: 22, weight: .semibold))
                    Spacer()
                    Text("\(tripViewModel.distance)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Time (min)")
                        .foregroundColor(.primary.opacity(0.7))
                        .font(.system(size: 22, weight: .semibold))
                    Spacer()
                    Text("\(tripViewModel.time)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Price (₹)")
                        .foregroundColor(.primary.opacity(0.7))
                        .font(.system(size: 22, weight: .semibold))
                    Spacer()
                    Text("\(tripViewModel.price)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }
            .listStyle(.plain)
            
            Button {
                // End Ride
                tripViewModel.endRide { success in
                    if success {
                        // Dismiss Riding View
                        dashboardViewModel.toggleShowRiding()
                        // Show Ride Completed View
                        dashboardViewModel.toggleShowRideCompleted()
                    }
                }
            } label: {
                Text(tripViewModel.ridingViewShowProgress ? "Final calculations..." : "End Ride")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(16)
            }
            .disabled(tripViewModel.ridingViewShowProgress)
        }
        .padding(.top, 44)
        .padding()
    }
}

struct RidingView_Previews: PreviewProvider {
    static var previews: some View {
        RidingView()
    }
}
