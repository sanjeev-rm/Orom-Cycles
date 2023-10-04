//
//  ChargesInfoView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/10/23.
//

import SwiftUI

struct ChargesInfoView: View {
    var body: some View {
        VStack {
            List {
                Section("Ride Charges") {
                    Group {
                        Text("Minimum of ₹10 will be charged for a ride.")
                        Text("The minimum charge is for the first 10 minutes.")
                        Text("₹0.5 will be charged for every minute after the first 10 minutes.")
                        Text("Charges for the ride will be deducted from your wallet, once you end the ride.")
                    }
                    .padding(3)
                    .font(.system(.footnote, design: .default, weight: .light))
                }
                
                Section("Wallet Charges") {
                    Group {
                        Text("Minimum of ₹50 must be added to the wallet during the fist time.")
                        Text("Minimum of ₹10 must be present in your wallet to start a ride.")
                    }
                    .padding(3)
                    .font(.system(.footnote, design: .default, weight: .light))
                }

            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle("Charges")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChargesInfoView()
    }
}
