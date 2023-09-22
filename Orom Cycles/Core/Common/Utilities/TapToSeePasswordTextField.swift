//
//  TapToSeePasswordField.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/08/23.
//

import SwiftUI

struct TapToSeeSecureField: View {
    var previewText: String
    @Binding var text: String
    @State var showPassword: Bool = false
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(previewText, text: $text)
            } else {
                SecureField(previewText, text: $text)
            }
            
            Spacer()
            
            Button {
                // Toggle show Password
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "lock.open" : "lock")
            }
        }
    }
}

struct TapToSeePasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        TapToSeeSecureField(previewText: "Current Password", text: .constant("Password"))
    }
}
