//
//  ProfileUpdatePasswordView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 04/08/23.
//

import SwiftUI

struct ProfileUpdatePasswordView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        Text("Update Password")
            .font(.title)
    }
}

struct ProfileUpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdatePasswordView()
    }
}
