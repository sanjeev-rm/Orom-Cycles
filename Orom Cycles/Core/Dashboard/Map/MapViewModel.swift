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
    static let startingLocation = CLLocationCoordinate2D(latitude: 26.6935017, longitude: 88.3258608)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    
    @Published var showMenu: Bool = false
    
    @Published var alert: OromAlert = OromAlert()
    
    @Published var nearByCyclesCoordinates: [CycleCoordinate] = []
    
//    var locationManager: CLLocationManager?

    struct CycleCoordinate: Identifiable {
        var latitude: Double
        var longitude: Double

        var id: String {
            "\(latitude)\(longitude)"
        }
    }
//
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
    
    func toggleShowMenu() {
        withAnimation(.easeInOut) {
            showMenu = !showMenu
        }
    }
    
    func showMapAlert(alertType: OromAlert.AlertType, message: String) {
        DispatchQueue.main.async {
            self.alert = OromAlert(showAlert: true, alertType: alertType, message: message)
        }
    }
    
    
    
    // MARK: - API Service functions
    
//    func showCyclesNearBy() {
//        self.showMapAlert(alertType: .customSystemImage(systemImage: "figure.outdoor.cycle", color: .accentColor), message: "Fetching cycles near you")
//        
//        guard let locationManager = locationManager, let location = locationManager.location else {
//            alert = OromAlert(showAlert: true, alertType: .failure, message: "Couldn't figure out your location")
//            return
//        }
//        
//        DashboardAPIService().getCycles(radius: 4000,
//                                        latitude: location.coordinate.latitude,
//                                        longitude: location.coordinate.longitude) { [unowned self] result in
//            DispatchQueue.main.async {
//                self.alert.showAlert = false
//            }
//            
//            switch result {
//            case .success(let cycles):
//                DispatchQueue.main.async {
//                    self.nearByCyclesCoordinates = cycles.cycles.map({ cycle in
//                        CycleCoordinate(latitude: cycle.location.coordinates[0], longitude: cycle.location.coordinates[1])
//                    })
//                }
//            case .failure(let error):
//                switch error {
//                case .noInternetConnection:
//                    self.showMapAlert(alertType: .customSystemImage(systemImage: "wifi.slash", color: Color(.tertiaryLabel)), message: "Check internet connection")
//                case .custom(let message):
//                    self.showMapAlert(alertType: .failure, message: message)
//                }
//            }
//        }
//    }
}
