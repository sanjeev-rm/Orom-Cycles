//
//  ContentView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            DashboardView()
        }
        else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
