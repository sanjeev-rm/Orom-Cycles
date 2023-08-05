//
//  WalletViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 05/08/23.
//

import Foundation

@MainActor
final class WalletViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var balance: Int = 0
    @Published var cardTapped: Bool = false
    @Published var showPickColorView: Bool = false
    @Published var walletCardGradientColor: WalletCardGradientColor = Storage.getWalletCardGradientColor()
    
    @Published var showProgress: Bool = false
    
    func updateWallet() {
        showProgress = true
        DashboardAPIService().getUserInfo { [unowned self] result in
            DispatchQueue.main.async {
                self.showProgress = false
                switch result {
                case .success(let response):
                    self.name = response.userData.info.name
                    self.balance = response.userData.info.balance
                case .failure(let failure):
                    switch failure {
                    case .noInternetConnection:
                        print("No internet connection")
                    case .custom(let message):
                        print(message)
                    }
                }
            }
        }
    }
}
