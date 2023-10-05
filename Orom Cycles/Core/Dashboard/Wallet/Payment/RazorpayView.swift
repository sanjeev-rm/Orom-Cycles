//
//  RazorPayView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 05/10/23.
//

import Foundation
import Razorpay
import SwiftUI

struct RazorpayView: UIViewControllerRepresentable {
    
    @State var razorKey: String
    @State var amount: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RazorpayView>) -> RazorViewController {
        let controller = RazorViewController()
        controller.razorKey = self.razorKey
        controller.amount = self.amount
        return controller
    }
        
    func updateUIViewController(_ uiViewController: RazorViewController, context: UIViewControllerRepresentableContext<RazorpayView>) {
        
    }
}

class RazorViewController: UIViewController {
    
    private var razorpay: RazorpayCheckout? = nil
    var razorKey = ""
    var amount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        razorpay = RazorpayCheckout.initWithKey(razorKey, andDelegateWithData: self)
        print("DEBUG: initialized Razorpay")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
//        openRazorpayCheckout(amount: amount)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("DEBUG: Called Open Razorpay Checkout")
        openRazorpayCheckout(amount: amount)
    }
    
    func openRazorpayCheckout(amount: String) {
        
        guard let amountInt = Int(amount) else {
            print("DEBUG: Amount couldn't be converted to Int")
            return
        }
        
        let options: [String:Any] = [
                    "amount": "\(amountInt * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
                    "currency": "INR",//We support more that 92 international currencies.
                    "description": "Add \(amountInt) to your wallet",
//                    "order_id": "order_DBJOWzybf0sJbb",
                    "image": "https://blogger.googleusercontent.com/img/a/AVvXsEjLtmCd6pvjH7CzjrR-SH-6xCEx--gdaowHFBVxb118j6OBUmL1ktxul4L917BauCYvoUxlNoVgntDAmAt0Weq7NoGd0d8LN3Ip-z7TWsmpB-O446JrT_Pf3k0ghSiBTvSJQPYqQaec-AnNgWFahYtT13CZmJ64f_QwtLGVhRH1M4rAh3I41pC6rbW_qbI=w1684-h1069-p-k-no-nu",
                    "name": "Orom Cycles",
                    "prefill": [
                        "contact": "9082883516",
                        "email": "oromcyclesios@gmail.com"
                    ],
                    "theme": [
                        "color": "#1B4571"
                    ]
                ]
        if let razorpay = self.razorpay {
            razorpay.open(options)
            print("DEBUG: Opened Razorpay")
        } else {
            print("DEBUG: Unable to open Razorpay")
        }
    }
}

extension RazorViewController: RazorpayPaymentCompletionProtocolWithData {
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        let alert = UIAlertController(title: "Paid", message: "Payment Success!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        let alert = UIAlertController(title: "Error", message: str, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
