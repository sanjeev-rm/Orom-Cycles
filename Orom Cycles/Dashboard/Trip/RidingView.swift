//
//  RidingView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 15/07/23.
//

import SwiftUI

struct RidingView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Dist : ")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    Text("0.5 km")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary.opacity(0.6))
                }
                HStack {
                    Text("Time : ")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    Text("\(2) min \(15) sec")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary.opacity(0.6))
                }
                HStack {
                    Text("Price : ")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    Text("₹ 7")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary.opacity(0.6))
                }
            }
            
            Button {
                // End Ride
                
                // Dismiss Riding View
                dashboardViewModel.toggleShowRiding()
                // Show Ride Completed View
                dashboardViewModel.toggleShowRideCompleted()
            } label: {
                Text("End Ride")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct RidingView_Previews: PreviewProvider {
    static var previews: some View {
        RidingView()
    }
}
