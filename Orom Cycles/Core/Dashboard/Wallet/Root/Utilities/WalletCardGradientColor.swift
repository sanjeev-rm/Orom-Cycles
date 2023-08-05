//
//  WalletCardGradientColors.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 05/08/23.
//

import Foundation
import SwiftUI

enum WalletCardGradientColor: CaseIterable, Identifiable, Codable {
    case accentColor
    case indigo
    case blue
    case yellow
    case green
    case cyan
    case mint
    
    var colors: [Color] {
        switch self {
        case .accentColor:
            return [.accentColor, .black.opacity(0.9)]
        case .indigo:
            return [Color(.systemIndigo), .black.opacity(0.9)]
        case .blue:
            return [Color(.systemBlue), .black.opacity(0.9)]
        case .yellow:
            return [Color(.systemYellow), .black.opacity(0.9)]
        case .green:
            return [Color(.systemGreen), .black.opacity(0.9)]
        case .cyan:
            return [Color(.systemCyan), .black.opacity(0.9)]
        case .mint:
            return [Color(.systemMint), .black.opacity(0.9)]
        }
    }
    
    var title: String {
        switch self {
        case .accentColor: return "Default"
        case .indigo: return "Indigo"
        case .blue: return "Blue"
        case .yellow: return "Yellow"
        case .green: return "Green"
        case .cyan: return "Cyan"
        case .mint: return "Mint"
        }
    }
    
    var id: [Color] {
        return self.colors
    }
}
