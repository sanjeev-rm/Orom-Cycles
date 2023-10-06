//
//  OromListButton.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/10/23.
//

import SwiftUI

struct OromListButtonLabel: View {
    
    var title: String
    var titleWeight: Font.Weight = .regular
    
    var imageSystemName: String
    var imageColor: Color = .secondary
    var imageFont: Font = .body
    
    var padding: CGFloat = 16
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: imageSystemName)
                .foregroundColor(imageColor)
                .font(imageFont)
            Text(title)
                .fontWeight(titleWeight)
            
            Spacer()
        }
        .padding(padding)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

#Preview {
    OromListButtonLabel(title: "Button", imageSystemName: "globe")
}
