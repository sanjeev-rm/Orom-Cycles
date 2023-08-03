//
//  CompletedRideView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/07/23.
//

import SwiftUI

struct CompletedRideView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            Text("Ride Complete!")
                .foregroundColor(.primary.opacity(0.8))
                .font(.system(size: 44, weight: .bold))
            
            HStack(spacing: 32) {
                Text("₹ " + "\(tripViewModel.price)")
                    .foregroundColor(.primary.opacity(0.7))
                    .font(.system(size: 44, weight: .bold))
                Spacer()
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color(.systemGreen))
                    .font(.system(size: 44))
            }
            
            Text("Amount has been deducted from your wallet")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button {
                // Dismiss Completed Ride
                dashboardViewModel.toggleShowRideCompleted()
            } label: {
                Text("Done")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(16)
            }
        }
        .padding(.top, 44)
        .padding()
    }
}

struct CompletedRideView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedRideView()
            .environmentObject(DashboardViewModel())
            .environmentObject(TripViewModel())
    }
}
