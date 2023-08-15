//
//  WalletView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct WalletView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    @EnvironmentObject var walletViewModel: WalletViewModel
    
    var body: some View {
        NavigationView {
            baseView
        }
    }
}



extension WalletView {
    
    private var baseView: some View {
        VStack(alignment: .leading, spacing: 32) {
            closeButtonAndTitle
            
            balanceCard
            
            addMoneyButton
            
            Spacer()
        }
        .padding(24)
        .onAppear {
            // Updating the wallet.
            walletViewModel.updateWallet()
        }
        .sheet(isPresented: $walletViewModel.showPickColorView) {
            WalletCardColorPicker()
                .environmentObject(walletViewModel)
                .presentationDetents([.medium])
        }
    }
    
    private var closeButtonAndTitle: some View {
        VStack(alignment: .leading) {
            closeButton
            title
        }
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                // Dissmiss view
                dashboardViewModel.toggleShowWallet()
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundColor(.primary)
        }
    }
    
    private var title: some View {
        Text("Wallet")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private var balanceCard: some View {
        
        ZStack {
            Rectangle()
                .stroke(lineWidth: 0)
                .background(
                    LinearGradient(colors: walletViewModel.walletCardGradientColor.colors, startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(32)

            VStack(alignment: .leading) {
                HStack {
                    Text(walletViewModel.name)
                        .foregroundColor(.white.opacity(0.8))
                        .font(.headline)
                    Spacer()
                    Rectangle()
                        .foregroundColor(.white.opacity(0.15))
                        .cornerRadius(32)
                        .frame(width: 70, height: 36)
                        .overlay {
                            if walletViewModel.showProgress {
                                ProgressView()
                                    .tint(.white)
                            }
                        }
                }

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Balance")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.subheadline)
                    Text("₹\(walletViewModel.balance)")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.system(.largeTitle, design: .monospaced))
                }
            }
            .padding(32)
            .shadow(radius: 1)
        }
        .frame(height: 230)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged{ _ in
                    walletViewModel.cardTapped = true
                }
                .onEnded{ _ in
                    walletViewModel.cardTapped = false
                    walletViewModel.showPickColorView = true
                }
        )
        .scaleEffect(walletViewModel.cardTapped ? 0.9 : 1)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: walletViewModel.cardTapped)
    }
    
    private var addMoneyButton: some View {
        HStack {
            NavigationLink {
                PaymentView()
            } label: {
                HStack {
                    Text("Add Money")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "plus")
                        .foregroundColor(.secondary)
                        .font(.title3)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
