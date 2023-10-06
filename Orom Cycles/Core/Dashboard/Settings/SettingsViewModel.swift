//
//  SettingsViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 07/08/23.
//

import Foundation

@MainActor
class SettingsViewModel: ObservableObject {
    
    @Published var showHelpView: Bool = false
    
    static var SUPPORT_MOBILE_NUMBER: String = "9082883516"
    
    static var SUPPORT_MAIL_ID: String = "oromcyclesios@gmail.com"
    
    var supportBugEmail: SupportEmail = SupportEmail(toAddress: SUPPORT_MAIL_ID,
                                                     subject: "BUG",
                                                     messageHeader: "Please describe the bug below")
    
    var supportSuggestionEmail: SupportEmail = SupportEmail(toAddress: SUPPORT_MAIL_ID,
                                                            subject: "SUGGESTION",
                                                            messageHeader: "Please describe your suggestion below")
    
    var supportHelpEmail: SupportEmail = SupportEmail(toAddress: SUPPORT_MAIL_ID,
                                                      subject: "HELP",
                                                      messageHeader: "What can we do for you?")
}
