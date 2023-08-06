//
//  WalletCardColorView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 05/08/23.
//

import SwiftUI

struct WalletCardColorView: View {
    
    @State var walletCardGradientColor: WalletCardGradientColor
    
    @Binding var selected: WalletCardGradientColor
    
    var body: some View {
        HStack {
            Circle()
                .stroke(lineWidth: 0)
                .frame(width: 44, height: 44)
                .background(
                    LinearGradient(colors: walletCardGradientColor.colors, startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(44)
            
            Text(walletCardGradientColor.title)
                .font(.callout)
                .fontWeight(.medium)
            
            Spacer()
            
            if selected == walletCardGradientColor {
                Image(systemName: "checkmark")
                    .font(.title)
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct WalletCardColorView_Previews: PreviewProvider {
    static var previews: some View {
        WalletCardColorView(walletCardGradientColor: .accentColor, selected: .constant(.accentColor))
    }
}
