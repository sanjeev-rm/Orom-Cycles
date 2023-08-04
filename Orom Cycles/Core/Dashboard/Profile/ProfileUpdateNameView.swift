//
//  UpdateNameView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/08/23.
//

import SwiftUI

struct ProfileUpdateNameView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            doneButton
            VStack(spacing: 32) {
                title
                textField
            }
            Spacer()
        }
        .padding()
    }
}



extension ProfileUpdateNameView {
    
    private var doneButton: some View {
        HStack {
            Button("Cancel") {
                // Dismiss View
                profileViewModel.toggleShowUpdateNameSheet()
            }
            Spacer()
            Button("Done") {
                // Update Name
                profileViewModel.updateName()
                profileViewModel.toggleShowUpdateNameSheet()
            }
        }
    }
    
    private var title: some View {
        HStack {
            Text("Update Name")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    private var textField: some View {
        TextField("New Name", text: $profileViewModel.name)
            .padding()
            .frame(height: 50)
            .background(Color(oromColor: .textFieldBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct ProfileUpdateNameView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdateNameView()
            .environmentObject(ProfileViewModel())
    }
}
