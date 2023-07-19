//
//  OnboardingScreenContent.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import Foundation
import SwiftUI

/// The Onboarding step Slide's.
/// The naming is done in order.
enum OnboardingStep: CaseIterable {
    case one
    case two
    case three
    case four
    
    /// The image for the OnboardingStep.
    /// - Returns: Image
    var image: Image {
        switch self {
        case .one: return Image("phone.map")
        case .two: return Image("phone.scanning")
        case .three: return Image("man.cycling")
        case .four: return Image("cycle.parked")
        }
    }
    
    /// The title for the OnboardingStep.
    /// - Returns: String
    var title: String {
        switch self {
        case .one: return "Find a Cycle"
        case .two: return "Scan and Unlock"
        case .three: return "Get on and Ride"
        case .four: return "Park and Lock"
        }
    }
    
    /// The description of the OnboardingStep.
    /// - Returns: String
    var description: String {
        switch self {
        case .one: return "Open the app and find all the Orom cycles around you."
        case .two: return "Scan the QR code in the bike to unlock it and begin your trip."
        case .three: return "Enjoy the ride to your destination"
        case .four: return "Park the cycle in the respective hubs. Then lock the cycle manually to end the trip."
        }
    }
}
