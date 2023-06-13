//
//  SignUpView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isPresenting: Bool
    var body: some View {
        NavigationView {
            Button {
                isPresenting.toggle()
            } label: {
                Text("Login")
            }
            .navigationTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isPresenting: .constant(true))
    }
}
