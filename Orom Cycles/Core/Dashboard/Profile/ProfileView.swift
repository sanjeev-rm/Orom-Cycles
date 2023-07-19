//
//  ProfileView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            closeButton
            
            Text("Profile")
                .font(.system(size: 32, weight: .ultraLight, design: .monospaced))
                .foregroundColor(.accentColor)
            
            logoutButton
                .padding(.top, 16)
            
            Spacer()
        }
    }
}



extension ProfileView {
    
    private var closeButton: some View {
        HStack {
            Button {
                // Dissmiss view
                dashboardViewModel.toggleShowProfile()
            } label: {
                Image(systemName: "xmark")
            }
            .padding()
            Spacer()
        }
    }
    
    private var logoutButton: some View {
        HStack {
            Spacer()
            
            Button {
                // Log out
                authenticationViewModel.updateLoggedInStatus(false)
            } label: {
                Text("Log Out")
                    .font(.system(size: 17, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .padding(8)
                    .background(Color(.systemRed))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
