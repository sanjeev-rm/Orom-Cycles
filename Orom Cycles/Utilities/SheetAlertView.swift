//
//  SheetAlertView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 21/08/23.
//

import SwiftUI

/// Custom Sheet Alert View for when showing alerts in form of sheets this is the view of the sheet.
/// Default is the progress type
struct SheetAlertView: View {
    
    var type: AlertType
    
    var imageSystemName: String?
    var text: String?
    
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
            default: return nil
            }
        }
        
        var text: String? {
            switch self {
            case .progress: return "Setting it all up for you"
            case .networkIssue: return "Make sure you're connected to Wi-Fi or your cellular network"
            case .locationIssue: return "Make sure you're location services are enabled"
            default: return nil
            }
        }
    }
    
    init(_ type: AlertType = .progress, imageSystemName: String? = nil, text: String? = nil) {
        self.type = type
        self.imageSystemName = imageSystemName
        self.text = text
        
        if type == .progress ||
           type == .networkIssue ||
           type == .locationIssue {
            self.imageSystemName = type.imageSystemName
            self.text = type.text
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
        SheetAlertView(.other, imageSystemName: "")
    }
}
