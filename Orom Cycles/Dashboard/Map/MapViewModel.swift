//
//  MapViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import Foundation
import MapKit
import SwiftUI

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 12.9692, longitude: 79.1559)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
}

extension MapView {
    
    final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
        @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                                   span: MapDetails.defaultSpan)
        
        @Published var showMenu: Bool = false
        
        @Published var alert: OromAlert = OromAlert()
        
        var locationManager: CLLocationManager?
        
        /// Function to check if the user has enabled Location services
        func checkIfLocationServiceEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager!.delegate = self
                self.locationManager!.activityType = .fitness
                self.locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            } else {
                print("Show users alert that locations is off and go turn it on")
            }
        }
        
        private func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Show Location Restricted Alert
                alert = OromAlert(showAlert: true, alertType: .customSystemImage(systemImage: "location.slash.fill", color: Color(.tertiaryLabel)), message: "Location Restricted")
            case .denied:
                // Show Location Denied Alert
                alert = OromAlert(showAlert: true, alertType: .customSystemImage(systemImage: "location.slash.fill", color: Color(.tertiaryLabel)), message: "Location Denied")
            case .authorizedAlways, .authorizedWhenInUse:
                // Show users location
                if let location = locationManager.location {
                    region = MKCoordinateRegion(center: location.coordinate,
                                                span: MapDetails.defaultSpan)
                }
            @unknown default:
                break
            }
        }
        
        // This function is called when the location manager is initialized
        // This function is also called everytime user changes authorization to location
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        func toggleShowMenu() {
            withAnimation(.easeInOut) {
                showMenu = !showMenu
            }
        }
    }
}
