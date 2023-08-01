//
//  WalletView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct WalletView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    // Dissmiss view
                    dashboardViewModel.toggleShowWallet()
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
                .padding(.top, 16)
            }
            
            Spacer()
            
            Text("Wallet")
                .font(.system(size: 32, weight: .ultraLight, design: .monospaced))
                .foregroundColor(.accentColor)
            
            Spacer()
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
