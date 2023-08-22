//
//  SheetAlertView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 21/08/23.
//

import SwiftUI

/// Custom Sheet Alert View for when showing alerts in form of sheets this is the view of the sheet.
/// Default is the progress type
/// If selecting other, please
struct SheetAlertView: View {
    
    var type: AlertType
    
    var imageSystemName: String?
    var text: String?
    
    /// The AlertType the type of alertyou want to present in the sheet
    enum AlertType {
        case progress
        case networkIssue
        case locationIssue
        case other
        
        var imageSystemName: String? {
            switch self {
            case .progress: return nil
            case .networkIssue: return "wifi.slash"
            case .locationIssue: return "location.slash"
            case .other: return "xmark"
            }
        }
        
        var text: String? {
            switch self {
            case .progress: return "Setting it all up for you"
            case .networkIssue: return "Make sure you're connected to Wi-Fi or your cellular network"
            case .locationIssue: return "Make sure you're location services are enabled"
            case .other: return "Something's gone wrong, we're working on it"
            }
        }
    }
    
    init(_ type: AlertType = .progress, imageSystemName: String? = nil, text: String? = nil) {
        self.type = type
        self.imageSystemName = imageSystemName
        self.text = text
        
        switch type {
        case .progress, .networkIssue, .locationIssue:
            self.imageSystemName = type.imageSystemName
            self.text = type.text
        case .other:
            self.imageSystemName = imageSystemName != nil ? imageSystemName : type.imageSystemName
            self.text = text != nil ? text : type.text
        }
    }
    
    var body: some View {
        VStack(spacing: 32) {
            if let imageSystemName = imageSystemName {
                Image(systemName: imageSystemName)
                    .font(.largeTitle)
                    .foregroundColor(Color.secondary)
            } else {
                ProgressView()
                    .controlSize(.large)
            }
            
            Text(text != nil ? text! : "Setting it all up for you")
                .font(.title3)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct SheetAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SheetAlertView(.other)
    }
}
