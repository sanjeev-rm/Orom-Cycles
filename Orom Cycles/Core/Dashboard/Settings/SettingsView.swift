//
//  SettingsView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    // Dissmiss view
                    dashboardViewModel.toggleShowSettings()
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
                .padding(.top, 16)
            }
            
            Spacer()
            
            Text("Settings")
                .font(.system(size: 32, weight: .ultraLight, design: .monospaced))
                .foregroundColor(.accentColor)
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
