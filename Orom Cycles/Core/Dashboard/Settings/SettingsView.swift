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
            ScrollView {
                VStack(spacing: 32) {
                    
                    helpButton
                    
                    bugAndSuggestionButtons
                    
                    writeAReviewButton
                    
                    developmentTeamButton
                    
                    Spacer()
                }
                .padding(.top, 8)
            }
        }
        .padding(24)
        .sheet(isPresented: $networkMonitor.isNotConnected) {
            SheetAlertView(.networkIssue)
                .presentationDetents([.height(175)])
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $settingsViewModel.showHelpView) {
            HelpView()
                .environmentObject(settingsViewModel)
                .presentationDetents([.medium])
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
            OromListButtonLabel(title: "Write a Review", titleWeight: .regular, imageSystemName: "pencil.line", imageFont: .body)
        }
    }
    
    private var helpButton: some View {
        Button {
            // Show help view
            settingsViewModel.showHelpView = true
        } label: {
            OromListButtonLabel(title: "Help", titleWeight: .regular, imageSystemName: "person.fill.questionmark", imageFont: .body, padding: 16)
        }
    }
    
    private var bugAndSuggestionButtons: some View {
        VStack(spacing: 16) {
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
            OromListButtonLabel(title: "Report a Bug", titleWeight: .regular, imageSystemName: "ladybug.fill", imageFont: .body, padding: 0)
        }
    }
    
    private var suggestionButton: some View {
        Button {
            // Show Email to send to support
            settingsViewModel.supportSuggestionEmail.send(openURL: openURL)
        } label: {
            OromListButtonLabel(title: "Give a suggestion", titleWeight: .regular, imageSystemName: "bonjour", imageFont: .body, padding: 0)
        }
    }
    
    private var developmentTeamButton: some View {
        Button {
            // Show The screen of developers
        } label: {
            OromListButtonLabel(title: "Developed by", titleWeight: .regular, imageSystemName: "hammer.fill", imageFont: .body)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(DashboardViewModel())
            .environmentObject(NetworkMonitor())
    }
}
