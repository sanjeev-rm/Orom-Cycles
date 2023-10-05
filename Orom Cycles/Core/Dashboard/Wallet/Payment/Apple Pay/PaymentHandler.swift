//
//  PaymentManager.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 05/10/23.
//

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard
    ]
    
    func makePayment(amount: String, completion: @escaping PaymentCompletionHandler) {
        
        completionHandler = completion
        
        guard let amountInt = Int(amount) else {
            completion(false)
            return
        }
        
        paymentSummaryItems = [PKPaymentSummaryItem(label: "This amount will be added to your wallet", amount: NSDecimalNumber(integerLiteral: amountInt), type: .final), PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(integerLiteral: amountInt), type: .final)]
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.OROM.orom-cycles"
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = "IN"
        paymentRequest.currencyCode = "INR"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.requiredBillingContactFields = [.name, .emailAddress, .phoneNumber]
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { presented in
            if presented {
                print("DEBUG: Presented payment controller")
            } else {
                print("DEBUG: Failed to present payment controller")
            }
        })
    }
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
            let errors = [Error]()
            let status = PKPaymentAuthorizationStatus.success
            
            self.paymentStatus = status
            completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    if let completionHandler = self.completionHandler {
                        completionHandler(true)
                    }
                } else {
                    if let completionHandler = self.completionHandler {
                        completionHandler(false)
                    }
                }
            }
        }
    }
}
