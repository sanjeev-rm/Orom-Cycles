//
//  WalletCardColorPicker.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 05/08/23.
//

import SwiftUI

struct WalletCardColorPicker: View {
    
    @EnvironmentObject var walletViewModel: WalletViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            title
            
            List(WalletCardGradientColor.allCases, id: \.id) { color in
                WalletCardColorView(walletCardGradientColor: color, selected: $walletViewModel.walletCardGradientColor)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            walletViewModel.walletCardGradientColor = color
                            // Storing the chosen wallet color
                            Storage.setWalletCardGradientColor(color)
                        }
                    }
            }
            .listStyle(.plain)
        }
        .padding(24)
    }
}



extension WalletCardColorPicker {
    
    private var title: some View {
        HStack {
            Spacer()
            Text("Card Color")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

struct WalletCardColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        WalletCardColorPicker()
            .environmentObject(WalletViewModel())
    }
}
