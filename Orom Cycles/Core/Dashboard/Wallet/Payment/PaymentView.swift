//
//  PaymentView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/08/23.
//

import SwiftUI
import Razorpay

struct PaymentView: View {
    
    @Environment(\.dismiss) var dismissView
    
    @StateObject var paymentViewModel = PaymentViewModel()
    
    var body: some View {
        
        paymentView
            .fullScreenCover(isPresented: $paymentViewModel.showRazorpayView) {
                // On Dismiss Reload the whole screen
            } content: {
                RazorpayView(razorKey: "rzp_test_aPE8A8hXxdSdZl", amount: paymentViewModel.amount)
                    .onAppear {
                        // This is done to presvent the navigation issue when presenting RazorPayView
                        paymentViewModel.showRazorpayView = false
                    }
            }
            .fullScreenCover(isPresented: $paymentViewModel.isPaymentSuccess) {
                // Dismiss this payment view too
                dismissView.callAsFunction()
            } content: {
                ApplePaySuccessView(amount: paymentViewModel.amount)
            }
    }
}



extension PaymentView {
    
    private var paymentView: some View {
        VStack(alignment: .leading, spacing: 32) {
            heading
            
            textField
            
            Spacer()
            
            VStack(spacing: 16) {
                
                payWithDivider
                
                applePayButton
                
                otherMethodsButton
            }
            .disabled(!paymentViewModel.isAmountValid)
        }
        .padding()
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            paymentViewModel.amount = paymentViewModel.isFirstTime ? "50" : "10"
        }
        .onChange(of: paymentViewModel.amount) { _ in
            paymentViewModel.validateAmount()
        }
    }
    
    private var heading: some View {
        VStack(alignment: .leading) {
            Text("Enter the amount")
                .font(.title.bold())
            
            Group {
                if paymentViewModel.isFirstTime {
                    Text("This is the first time you're adding funds, so a minimum amount of ₹50 must be added")
                } else {
                    Text("You can add a minimum of ₹10")
                }
            }
            .font(.caption.weight(.regular))
            .foregroundColor(Color(.secondaryLabel))
        }
    }
    
    private var textField: some View {
        HStack {
            Text("₹")
            TextField("0", text: $paymentViewModel.amount)
                .keyboardType(.numberPad)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 3)
                        .foregroundColor(paymentViewModel.isAmountValid ? .clear : Color(.systemRed).opacity(0.6))
                )
                .background(Color(oromColor: .textFieldBackground))
                .cornerRadius(16)
        }
        .font(.title2.monospaced())
    }
    
    private var payWithDivider: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
            Text("Pay with")
                .font(.caption)
                .foregroundColor(Color(.secondaryLabel))
            Rectangle()
                .frame(height: 1)
        }
        .foregroundColor(Color(.tertiaryLabel))
    }
    
    private var applePayButton: some View {
        ApplePayButton {
            // Implement Apple payment process
            paymentViewModel.makePaymentUsingApplePay()
        }
        .cornerRadius(8)

    }
    
    private var otherMethodsButton: some View {
        Button {
            // Implement razor pay
            paymentViewModel.showRazorpayView = true
        } label: {
            Text("Others")
                .frame(maxWidth: .infinity)
                .font(.title3.weight(.medium))
                .foregroundColor(.white)
                .frame(minWidth: 100, maxWidth: 400)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(Color(.accent))
                .cornerRadius(8)
        }

    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaymentView()
        }
    }
}
