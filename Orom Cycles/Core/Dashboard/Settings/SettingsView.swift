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
        VStack(spacing: 32) {
            closeButtonAndTitle
            
            themePicker
            
            writeAReviewButton
            
            reportABugButton
            
            Spacer()
        }
        .padding(24)
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
                dashboardViewModel.toggleShowWallet()
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
            HStack {
                Text("Theme")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Dark <>")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
        }
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
