//
//  PaymentView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/08/23.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaymentView()
        }
    }
}
