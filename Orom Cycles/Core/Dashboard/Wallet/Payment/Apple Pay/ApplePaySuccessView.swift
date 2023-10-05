//
//  ApplePaySuccessView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/10/23.
//

import SwiftUI

struct ApplePaySuccessView: View {
    
    @Environment(\.dismiss) var dismissView
    
    var amount: String
    
    var body: some View {
        VStack {
            VStack(spacing: 32) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .dynamicTypeSize(.accessibility2)
                    .padding(32)
                    .background(
                        Circle()
                            .foregroundColor(Color(.systemGreen))
                            .shadow(radius: 8)
                    )
                
                VStack(spacing: 16) {
                    Text("₹\(amount)")
                        .font(.system(.title, design: .default, weight: .semibold))
                    Text("has been added to your wallet")
                        .font(.body.weight(.regular))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top, UIScreen.main.bounds.height / 5)
            
            Spacer()
            
            Button {
                dismissView.callAsFunction()
            } label: {
                Text("Go to Wallet")
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(Color(.accent))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .shadow(radius: 0)

        }
    }
}

#Preview {
    ApplePaySuccessView(amount: "100")
}
