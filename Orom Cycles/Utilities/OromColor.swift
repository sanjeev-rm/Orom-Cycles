//
//  OromColor.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 08/07/23.
//

import Foundation
import SwiftUI

enum OromColor: String {
    case textFieldBackground = "textField.background.color"
    case labelPrimary = "label.primary"
    case labelSecondary = "label.secondary"
    case shadowColor = "shadow.color"
    case brownColor = "brown.color"
}

extension Color {
    init(oromColor: OromColor) {
        self.init(oromColor.rawValue)
    }
}
