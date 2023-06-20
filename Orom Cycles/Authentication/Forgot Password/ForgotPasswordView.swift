//
//  ForgotPasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    var body: some View {
        NavigationView {
            EmailAddressView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
