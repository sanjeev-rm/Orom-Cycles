//
//  PaymentViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/10/23.
//

import Foundation

class PaymentViewModel: ObservableObject {
    
    @Published var isFirstTime: Bool = false
    @Published var amount: String = ""
    @Published var isAmountValid: Bool = true
    
    @Published var showRazorpayView: Bool = false
    
    @Published var isPaymentSuccess: Bool = false
    
    let applePaymentHandler: ApplePaymentHandler = ApplePaymentHandler()
    
    func validateAmount() {
        guard let amountInt = Int(amount) else {
            isAmountValid = false
            return
        }
        
        if isFirstTime, amountInt < 50 {
            isAmountValid = false
        } else if amountInt < 10 {
            isAmountValid = false
        } else {
            isAmountValid = true
        }
    }
    
    func makePaymentUsingApplePay() {
        applePaymentHandler.makePayment(amount: amount) { success in
            self.isPaymentSuccess = success
        }
    }
}
