//
//  AppViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/08/23.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    
    @AppStorage(Storage.Key.appThemeString.rawValue) var appThemeString: String = AppTheme.system.rawValue
    
    enum AppTheme: String, CaseIterable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"
    }
    
    var appColorScheme: ColorScheme? {
        switch appThemeString {
        case AppTheme.system.rawValue: return nil
        case AppTheme.light.rawValue: return .light
        case AppTheme.dark.rawValue: return .dark
        default: return nil
        }
    }
}
