//
//  SettingsView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            closeButtonAndTitle
            
// Commented this out, cause this has issue when system option is selected
//            themePicker
            
            writeAReviewButton
            
            reportABugButton
            
            developmentTeamButton
            
            Spacer()
        }
        .padding(24)
//        .preferredColorScheme(appViewModel.appColorScheme)
    }
}



extension SettingsView {
    
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
                dashboardViewModel.toggleShowSettings()
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundColor(.primary)
        }
    }
    
    private var title: some View {
        Text("Settings")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private var themePicker: some View {
        HStack {
            Text("Theme")
                .font(.headline)
            
            Spacer()
            
            Picker("Pick a Theme", selection: $appViewModel.appThemeString) {
                let themesStringArray = AppViewModel.AppTheme.allCases.map({ theme in
                    theme.rawValue
                })
                ForEach(themesStringArray, id: \.self) { themeString in
                    Text(themeString)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
    
    private var writeAReviewButton: some View {
        Button {
            // Show Review page in App Store
        } label: {
            HStack {
                Text("Write a Review")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "pencil.line")
                    .foregroundColor(.secondary)
                    .font(.title3)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
        }
    }
    
    private var reportABugButton: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                // Show Email to send to support and bug as subject
            } label: {
                HStack {
                    Text("Report a Bug")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "ant.fill")
                        .foregroundColor(.secondary)
                        .font(.title3)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
            }
            
            Text("Or just shake the phone thrice")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading, 16)
        }
    }
    
    private var developmentTeamButton: some View {
        Button {
            // Show The screen of developers
        } label: {
            HStack {
                Text("Developed By")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "hammer.fill")
                    .foregroundColor(.secondary)
                    .font(.title3)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppViewModel())
            .environmentObject(DashboardViewModel())
    }
}
