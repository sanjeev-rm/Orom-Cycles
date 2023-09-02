//
//  MapView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                
                map.safeAreaInset(edge: .bottom) {
                        scannerButton
                    }
                
                topBar
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $mapViewModel.showUserLocationIssue) {
                SheetAlertView(.locationIssue)
                    .presentationDetents([.height(175)])
            }
            .onAppear {
                mapViewModel.checkUserLocation()
            }
            .onChange(of: scenePhase) { _ in
                mapViewModel.checkUserLocation()
            }
        }
    }
}



extension MapView {
    private var map: some View {
        OromMapViewRepresentable()
            .environmentObject(mapViewModel)
            .ignoresSafeArea()
    }
    
    private var scannerButton: some View {
        Button {
            // Open Scanner
            dashboardViewModel.toggleShowScanner()
        } label: {
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 44))
                .padding()
                .background(.thickMaterial)
                .cornerRadius(24)
                .padding(16)
                .shadow(radius: 16)
        }
    }
    
    private var topBar: some View {
        VStack(spacing: 16) {
            menu
            
            if mapViewModel.userLocationDisabled {
                userLocationDisabledButton
            }
        }
        .padding()
    }
    
    private var userLocationDisabledButton: some View {
        Button {
            // Show no location message
            mapViewModel.showUserLocationIssue = true
        } label: {
            menuButtonLabel(systemName: "location.slash")
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 16)
        .background(.thickMaterial)
        .cornerRadius(16)
        .shadow(radius: 16)
    }
    
    private var menu: some View {
        VStack(spacing: 32) {
            Button {
                // Open menu
                mapViewModel.toggleShowMenu()
            } label: {
                menuButtonLabel(systemName: "line.3.horizontal")
            }
            
            if mapViewModel.showMenu {
                
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
        .background(.thickMaterial)
        .cornerRadius(16)
        .shadow(radius: 16)
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
            .environmentObject(NetworkMonitor())
    }
}
