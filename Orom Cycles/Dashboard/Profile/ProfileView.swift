//
//  ProfileView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack {
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
            
            Spacer()
            
            Text("Profile")
                .font(.system(size: 32, weight: .ultraLight, design: .monospaced))
                .foregroundColor(.accentColor)
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
