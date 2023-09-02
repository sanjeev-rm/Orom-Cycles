//
//  MapViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation

class MapViewModel: ObservableObject {
    
    @Published var showMenu: Bool = false
    
    @Published var userLocationDisabled: Bool = false
    
    @Published var showUserLocationIssue: Bool = false
    
    let locationManager = CLLocationManager()
    
    init(showMenu: Bool = false, showUserLocationIssue: Bool = false) {
        self.showMenu = showMenu
        self.showUserLocationIssue = showUserLocationIssue
        self.checkUserLocation()
    }
    
    func toggleShowMenu() {
        withAnimation(.easeInOut) {
            showMenu = !showMenu
        }
    }
    
    func checkUserLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            userLocationDisabled = true
        default:
            userLocationDisabled = false
        }
    }
}
