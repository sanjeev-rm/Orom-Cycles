//
//  ForgotPasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var isPresenting: Bool
    var body: some View {
        NavigationView {
            EmailAddressView(isPresenting: $isPresenting)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(isPresenting: .constant(true))
    }
}
