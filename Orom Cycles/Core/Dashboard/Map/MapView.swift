//
//  MapView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI
import MapKit
import AlertToast

struct MapView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    @StateObject var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                
                map.safeAreaInset(edge: .bottom) {
                        scannerButton
                    }
                
                menu
            }
            .navigationBarTitleDisplayMode(.inline)
            .toast(isPresenting: $viewModel.alert.showAlert, duration: 32) {
                OromAlert.getAlertToast(with: viewModel.alert.message, viewModel.alert.alertType, displayMode: .hud)
            }
        }
    }
}



extension MapView {
    private var map: some View {
        Map(coordinateRegion: $viewModel.region,
            interactionModes: [.all],
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: viewModel.nearByCyclesCoordinates) { coordinate in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.checkIfLocationServiceEnabled()
        }
    }
    
    private var scannerButton: some View {
        Button {
            // Open Scanner
            dashboardViewModel.toggleShowScanner()
        } label: {
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 44))
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(24)
                .padding(16)
                .shadow(radius: 16)
        }
    }
    
    private var menu: some View {
        VStack(spacing: 32) {
            Button {
                // Open menu
                viewModel.toggleShowMenu()
            } label: {
                menuButtonLabel(systemName: "line.3.horizontal")
            }
            
            if viewModel.showMenu {
                
                Button {
                    // Profile
                    dashboardViewModel.toggleShowProfile()
                } label: {
                    menuButtonLabel(systemName: "person")
                }
                
                Button {
                    // Wallet
                    dashboardViewModel.toggleShowWallet()
                } label: {
                    menuButtonLabel(systemName: "creditcard")
                }
                
                Button {
                    // Settings
                    dashboardViewModel.toggleShowSettings()
                } label: {
                    menuButtonLabel(systemName: "gear")
                }
            }
        }
        .padding(16)
        .background(.ultraThickMaterial)
        .cornerRadius(16)
        .shadow(radius: 016)
        .padding()
    }
    
    private func menuButtonLabel(systemName: String) -> some View {
        Image(systemName: systemName)
            .font(.system(size: 24, weight: .semibold))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(DashboardViewModel())
    }
}
