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
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            VStack(alignment: .leading) {
                closeButton
                
                title
                    .listRowSeparator(.hidden)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                name
                
                Divider()
                
                email
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
            
            updatePasswordButton
            
            logoutButton
            
            Spacer()
        }
        .padding(24)
        .sheet(isPresented: $profileViewModel.showUpdateNameSheet) {
            ProfileUpdateNameView()
                .environmentObject(profileViewModel)
        }
        .sheet(isPresented: $profileViewModel.showUpdatePasswordSheet) {
            ProfileUpdatePasswordView()
                .environmentObject(profileViewModel)
        }
    }
}



extension ProfileView {
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                // Dissmiss view
                dashboardViewModel.toggleShowProfile()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
    
    private var title: some View {
        Text("Profile")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private var name: some View {
        HStack {
            Text("Name")
                .font(.headline)
            Spacer()
            Text(profileViewModel.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .onTapGesture {
                    profileViewModel.showUpdateNameSheet = true
                }
        }
    }
    
    private var email: some View {
        HStack {
            Text("Email")
                .font(.headline)
            Spacer()
            Text(profileViewModel.email)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }
    
    private var updatePasswordButton: some View {
        Button {
            // Show Update Password Sheet
            profileViewModel.showUpdatePasswordSheet = true
        } label: {
            HStack {
                Image(systemName: "lock")
                Text("Update Password")
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
        }
    }
    
    private var logoutButton: some View {
        Button {
            // Log out
            dashboardViewModel.toggleShowProfile()
            authenticationViewModel.updateLoggedInStatus(false)
        } label: {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(Color(uiColor: .systemRed))
                Text("Log Out")
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
