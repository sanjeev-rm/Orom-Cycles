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
        Text("Update Name")
            .font(.title)
    }
}

struct ProfileUpdateNameView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdateNameView()
    }
}
