//
//  Bundle+Extension.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 07/08/23.
//

import Foundation

extension Bundle {
    var displayName: String {
        object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Couldn't determine the App Name"
    }
    
    var appBuild: String {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Couldn't determine the App Build Number"
    }
    
    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Couldn't determine the App Version"
    }
}
