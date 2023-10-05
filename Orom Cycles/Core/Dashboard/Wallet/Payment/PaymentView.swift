//
//  PaymentView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/08/23.
//

import SwiftUI

struct PaymentView: View {
    
    @State var isFirstTime: Bool = false
    @State var amount: String = ""
    @State var isAmountValid: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            heading
            
            textField
            
            Spacer()
            
            VStack(spacing: 16) {
                
                payWithDivider
                
                applePayButton
                
                otherMethodsButton
            }
            .disabled(!isAmountValid)
        }
        .padding()
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            amount = isFirstTime ? "50" : "10"
        }
        .onChange(of: amount) { _ in
            validateAmount()
        }
    }
}



extension PaymentView {
    
    private var heading: some View {
        VStack(alignment: .leading) {
            Text("Enter the amount")
                .font(.title.bold())
            
            Group {
                if isFirstTime {
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
            TextField("0", text: $amount)
                .keyboardType(.numberPad)
                .submitLabel(.return)
                .padding()
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
        Button {
            // Configure Apple pay
        } label: {
            HStack {
                Image(systemName: "apple.logo")
                Text("Pay")
            }
            .frame(maxWidth: .infinity)
            .font(.title3)
            .foregroundColor(Color(.systemBackground))
            .padding()
            .background(Color(.label))
            .cornerRadius(8)
        }

    }
    
    private var otherMethodsButton: some View {
        Button {
            // Implement razor pay
        } label: {
            Text("Others")
                .frame(maxWidth: .infinity)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .background(Color(.accent))
                .cornerRadius(8)
        }

    }
}

extension PaymentView {
    
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
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaymentView()
        }
    }
}
