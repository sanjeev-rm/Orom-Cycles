//
//  CompletedRideView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/07/23.
//

import SwiftUI

struct CompletedRideView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Completed Ride!")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary.opacity(0.7))
            
            HStack(spacing: 32) {
                Text("₹ 17")
                    .font(.system(size: 44, weight: .bold))
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color(.systemGreen))
                    .font(.system(size: 44))
            }
            
            Button {
                // Dismiss Completed Ride
                dashboardViewModel.toggleShowRideCompleted()
            } label: {
                Text("Done")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct CompletedRideView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedRideView()
    }
}
