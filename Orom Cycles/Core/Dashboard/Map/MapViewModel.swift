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
    
//    @Published var alert: OromAlert = OromAlert()
    
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
    
//    func showMapAlert(alertType: OromAlert.AlertType, message: String) {
//        DispatchQueue.main.async {
//            self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
//        }
//    }

//    /// Function to check if the user has enabled Location services
//    func checkIfLocationServiceEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            self.locationManager = CLLocationManager()
//            self.locationManager!.delegate = self
//            self.locationManager!.activityType = .fitness
//            self.locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        } else {
//            print("Show users alert that locations is off and go turn it on")
//        }
//    }
//
//    private func checkLocationAuthorization() {
//        guard let locationManager = locationManager else { return }
//
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // Show Location Restricted Alert
//            alert = OromAlert(showAlert: true, alertType: .customSystemImage(systemImage: "location.slash.fill", color: Color(.tertiaryLabel)), message: "Location Restricted")
//        case .denied:
//            // Show Location Denied Alert
//            alert = OromAlert(showAlert: true, alertType: .customSystemImage(systemImage: "location.slash.fill", color: Color(.tertiaryLabel)), message: "Location Denied")
//        case .authorizedAlways, .authorizedWhenInUse:
//            // Show users location
//            if let location = locationManager.location {
//                // Setting maps region to users location
//                region = MKCoordinateRegion(center: location.coordinate,
//                                            span: MapDetails.defaultSpan)
//                // Showing cycles near by
//                showCyclesNearBy()
//            }
//        @unknown default:
//            break
//        }
//    }
//
//    // This function is called when the location manager is initialized
//    // This function is also called everytime user changes authorization to location
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
}
