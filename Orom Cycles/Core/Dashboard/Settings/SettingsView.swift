//
//  SettingsView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @Environment(\.openURL) var openURL
    
    @ObservedObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            closeButtonAndTitle
            
            writeAReviewButton
            
            bugAndSuggestionButtons
            
            developmentTeamButton
            
            Spacer()
        }
        .padding(24)
        .sheet(isPresented: $networkMonitor.isNotConnected) {
            SheetAlertView(.networkIssue)
                .presentationDetents([.height(175)])
                .interactiveDismissDisabled()
        }
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
    
    private var bugAndSuggestionButtons: some View {
        VStack {
            reportABugButton
            Divider()
            suggestionButton
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
    
    private var reportABugButton: some View {
        Button {
            // Show Email to send to support
            settingsViewModel.supportBugEmail.send(openURL: openURL)
        } label: {
            HStack {
                Text("Report a Bug")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "ant.fill")
                    .foregroundColor(.secondary)
                    .font(.title3)
            }
        }
    }
    
    private var suggestionButton: some View {
        Button {
            // Show Email to send to support
            settingsViewModel.supportSuggestionEmail.send(openURL: openURL)
        } label: {
            HStack {
                Text("Give a suggestion")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "bonjour")
                    .foregroundColor(.secondary)
                    .font(.title3)
            }
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
            .environmentObject(DashboardViewModel())
    }
}
