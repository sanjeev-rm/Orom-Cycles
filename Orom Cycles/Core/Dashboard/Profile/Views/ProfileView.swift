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
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            closeButtonAndTitle
            
            nameAndEmail
            
            updatePasswordButton
            
            logoutButton
            
            Spacer()
        }
        .onAppear {
            profileViewModel.getUserInfo()
        }
        .padding(24)
        .sheet(isPresented: $networkMonitor.isNotConnected) {
            SheetAlertView(.networkIssue)
                .presentationDetents([.height(175)])
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $profileViewModel.showUpdateNameSheet) {
            ProfileUpdateNameView()
                .presentationDetents([.fraction(0.3)])
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $profileViewModel.showUpdatePasswordSheet) {
            ProfileUpdatePasswordView()
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        }
        .confirmationDialog("", isPresented: $profileViewModel.showConfirmationForLogOut) {
            Button("Log Out", role: .destructive) {
                // Log out
                dashboardViewModel.toggleShowProfile()
                authenticationViewModel.updateLoggedInStatus(false)
            }
        } message: {
            Text("Are you sure want to log out?")
        }
    }
}



extension ProfileView {
    
    private var closeButtonAndTitle: some View {
        VStack(alignment: .leading) {
            closeButton
            title
        }
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                // Dissmiss view
                dashboardViewModel.toggleShowProfile()
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundColor(.primary)
        }
    }
    
    private var title: some View {
        Text("Profile")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private var nameAndEmail: some View {
        VStack(alignment: .leading, spacing: 16) {
            name
            Divider()
            email
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(16)
    }
    
    private var name: some View {
        HStack {
            Text("Name")
                .font(.headline)
            Spacer()
            if profileViewModel.showProgress {
                ProgressView()
            } else {
                Text(profileViewModel.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        profileViewModel.toggleShowUpdateNameSheet()
                    }
            }
        }
    }
    
    private var email: some View {
        HStack {
            Text("Email")
                .font(.headline)
            Spacer()
            if profileViewModel.showProgress {
                ProgressView()
            } else {
                Text(profileViewModel.email)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var updatePasswordButton: some View {
        Button {
            // Show Update Password Sheet
            profileViewModel.toggleShowUpdatePasswordSheet()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "lock")
                    .foregroundColor(.secondary)
                    .font(.title3)
                Text("Update Password")
                    .fontWeight(.regular)
                
                Spacer()
                
                if profileViewModel.showPasswordUpdated {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(.systemGreen))
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
        }
    }
    
    private var logoutButton: some View {
        
        Button {
            // Show Confirmation Dialogue
            profileViewModel.toggleShowConfirmationForLogOut()
        } label: {
            OromListButtonLabel(title: "Log Out",
                                titleWeight: .regular,
                                imageSystemName: "rectangle.portrait.and.arrow.right",
                                imageColor: Color(.systemRed))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(DashboardViewModel())
            .environmentObject(AuthenticationViewModel())
            .environmentObject(NetworkMonitor())
            .environmentObject(ProfileViewModel())
    }
}
