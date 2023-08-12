//
//  OromMapViewRepresentable.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/08/23.
//

import Foundation
import SwiftUI
import MapKit

struct OromMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}



// MARK: - MapCoordinator

extension OromMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: Properties
        
        let parent: OromMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        
        
        // MARK: Lifecycle
        
        init(parent: OromMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        
        // MARK: MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            parent.mapView.setRegion(region, animated: true)
            addNearbyCyclesAnnotations()
        }
        
        // MARK: Helpers
        
        func addNearbyCyclesAnnotations() {
            guard let userLocationCoordinate = self.userLocationCoordinate else {
                print("DEBUG: Couldn't determine user location for fetching nearby cycles coordinates")
                return
            }
            
            DashboardAPIService().getCycles(radius: 700,
                                            latitude: userLocationCoordinate.latitude,
                                            longitude: userLocationCoordinate.longitude) { result in
                switch result {
                case .success(let cycles):
                    for cycle in cycles.cycles {
                        let coordinate = CLLocationCoordinate2D(latitude: cycle.location.coordinates[0], longitude: cycle.location.coordinates[1])
                        self.addAnnotation(withCoordinate: coordinate)
                    }
                case .failure(let error):
                    switch error {
                    case .noInternetConnection:
                        print("DEBUG: NO internet error, When fetching nearby cycles coordinates")
                    case .custom(let message):
                        print("DEBUG: Custom error while fetching nearby cycles coordinates \(message)")
                    }
                }
            }
        }
        
        func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            DispatchQueue.main.async {
                self.parent.mapView.addAnnotation(annotation)
                self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
            }
        }
    }
}
