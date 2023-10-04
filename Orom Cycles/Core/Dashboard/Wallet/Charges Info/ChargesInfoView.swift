//
//  ChargesInfoView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/10/23.
//

import SwiftUI

struct ChargesInfoView: View {
    var body: some View {
        VStack {
            Text("₹")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
        }
        .navigationTitle("Charges")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChargesInfoView()
}
