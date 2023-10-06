//
//  HelpView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/10/23.
//

import SwiftUI

struct HelpView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Button {
                    callNumber(phoneNumber: SettingsViewModel.SUPPORT_MOBILE_NUMBER)
                } label: {
                    Label {
                        Text("+91 \(SettingsViewModel.SUPPORT_MOBILE_NUMBER)")
                    } icon: {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                    }
                    .padding(16)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    settingsViewModel.supportHelpEmail.send(openURL: openURL)
                } label: {
                    Label {
                        Text(SettingsViewModel.SUPPORT_MAIL_ID)
                    } icon: {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                    }
                    .padding(16)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Help")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        settingsViewModel.showHelpView = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }
}

extension HelpView {
    
    private func infoView(title: String, button: some View) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
            
            button
        }
    }
    
    private func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}

#Preview {
    HelpView()
}
