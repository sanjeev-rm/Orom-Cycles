//
//  SettingsViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 07/08/23.
//

import Foundation

extension SettingsView {
    @MainActor
    class SettingsViewModel: ObservableObject {
        
        var supportBugEmail: SupportEmail = SupportEmail(toAddress: "oromcyclesios@gmail.com",
                                                         subject: "Reporting a Bug [Orom Cycles]",
                                                         messageHeader: "Please describe the bug below")
        
        var supportSuggestionEmail: SupportEmail = SupportEmail(toAddress: "oromcyclesios@gmail.com",
                                                                subject: "Providing Suggestions [Orom Cycles]",
                                                                messageHeader: "Please describe your suggestion below")
    }
}
