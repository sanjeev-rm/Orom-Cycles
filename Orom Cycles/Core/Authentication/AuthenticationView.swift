//
//  AuthenticationView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 17/06/23.
//

import SwiftUI
import AlertToast

struct AuthenticationView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        LoginView()
            .toast(isPresenting: $authenticationViewModel.showUpdatedPasswordAlert, duration: 2.78, tapToDismiss: false) {
                AlertToast(displayMode: .hud,
                           type: .complete(Color(uiColor: .systemGreen)),
                           title: "Updated Password",
                           subTitle: "Login with new credentials")
            }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(AuthenticationViewModel())
    }
}
