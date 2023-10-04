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
    
//    @State var currentDate: Date = Date()
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    /// Initial price is 10
    @State var price: Int = 10
    /// The duration of the ride
    @State var rideTimeString: String = "00:00:00"
    /// The eact date at which this ride began
    let startDate: Date = Date()
    
    func updateRideDetails() {
        let rideTime = Calendar.current.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
        let hour = rideTime.hour ?? 0
        let minute = rideTime.minute ?? 0
        let second = rideTime.second ?? 0
        rideTimeString = "\(hour):\(minute):\(second)"
        
        if hour == 0 && minute <= 15 {
            print("DEBUG: price will be 10 only")
        } else {
            let totalMinutes = hour * 60 + minute
            let extraChargeableMinutes = totalMinutes - 15
            price = 10 + (extraChargeableMinutes * 2)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            header
            
            infoList
            
            endRideButton
        }
        .padding(.top, 44)
        .padding()
        .onReceive(timer, perform: { value in
            updateRideDetails()
        })
    }
}



extension RidingView {
    
    private var header: some View {
        Text("Trip Details")
            .foregroundColor(.primary.opacity(0.8))
            .font(.system(size: 44, weight: .bold))
    }
    
    private var endRideButton: some View {
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
    
    private var infoList: some View {
        List {
//                infoRow(title: "Dist (km)", value: "\(tripViewModel.distance)")
            infoRow(title: "Time (min)", value: rideTimeString)
            infoRow(title: "Price (₹)", value: "\(price)")
        }
        .listStyle(.plain)
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.primary.opacity(0.7))
                .font(.system(size: 22, weight: .semibold))
            Spacer()
            Text(value)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.secondary)
        }
    }
}

struct RidingView_Previews: PreviewProvider {
    static var previews: some View {
        RidingView()
            .environmentObject(DashboardViewModel())
            .environmentObject(TripViewModel())
    }
}
