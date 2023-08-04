//
//  TapToSeePasswordField.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/08/23.
//

import SwiftUI

struct TapToSeePasswordTextField: View {
    var previewText: String
    @Binding var textValue: String
    @State var showPassword: Bool = false
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(previewText, text: $textValue)
            } else {
                SecureField(previewText, text: $textValue)
            }
            
            Spacer()
            
            Button {
                // Toggle show Password
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye" : "eye.slash")
            }
        }
    }
}

struct TapToSeePasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        TapToSeePasswordTextField(previewText: "Current Password", textValue: .constant("Password"))
    }
}
