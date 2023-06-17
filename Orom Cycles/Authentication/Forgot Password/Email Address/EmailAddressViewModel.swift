//
//  EmailAddressViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/06/23.
//

import Foundation

extension EmailAddressView {
    @MainActor class ViewModel: ObservableObject {
        @Published var email: String = "" {
            didSet {
                isVerifyButtonDisabled = email.isEmpty
            }
        }
        @Published var isVerifyButtonDisabled: Bool = true
    }
}
