//
//  VerificationView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct DashboardView: View {
    @State var isLoggedIn: Bool = false
    var body: some View {
        Text("Dashboard")
            .font(.system(size: 32, weight: .ultraLight, design: .monospaced))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
