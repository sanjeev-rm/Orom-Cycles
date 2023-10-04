//
//  TripViewModel.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 02/08/23.
//

import Foundation
import SwiftUI

final class TripViewModel:ObservableObject {
    
    @Published var cycleName: String = "Cycle Default"
    @Published var cycleId: String = ""
    @Published var distance: Double = 0.0
    @Published var time: Double = 0.0
    @Published var price: Double = 0.0
    
    @Published var startRideViewShowProgress: Bool = false
    
    // Start Ride view errors
    @Published var showInsufficientFundsError: Bool = false
    @Published var showUnableToStartRideError: Bool = false
    
    @Published var ridingViewShowProgress: Bool = false
    
    func setToDefault() {
        self.showInsufficientFundsError = false
        self.showUnableToStartRideError = false
    }
    
    // MARK: - StartRideView function
    
    func startRideWithCycle(completion: @escaping (Bool) -> Void) {
        startRideViewShowProgress = true
        
        DashboardAPIService().startRide(cycleId: cycleId) { [unowned self] result in
            DispatchQueue.main.async {
                self.startRideViewShowProgress = false
            }
            
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                switch error {
                case .insufficientFunds:
                    print("DEBUG: " + error.localizedDescription)
                    DispatchQueue.main.async {
                        self.showInsufficientFundsError = true
                    }
                case .noInternetConnection:
                    print("DEBUG: " + error.localizedDescription)
                    DispatchQueue.main.async {
                        self.showUnableToStartRideError = true
                    }
                case .custom(let message):
                    print(message)
                    DispatchQueue.main.async {
                        self.showUnableToStartRideError = true
                    }
                }
                completion(false)
            }
        }
    }
    
    // MARK: - RidingView function
    
    func endRide(completion: @escaping (Bool) -> Void) {
        ridingViewShowProgress = true
        
        DashboardAPIService().getActiveBooking { result in
            switch result {
            case .success(let response):
                // After getting the current active booking Id sending it to the End ride API to end the current ride
                DashboardAPIService().endRide(bookingId: response.data.bookingId) { [unowned self] result in
                    DispatchQueue.main.async {
                        self.ridingViewShowProgress = false
                    }
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.price = response.cost
                        }
                        completion(true)
                    case .failure(let error):
                        switch error {
                        case .noInternetConnection:
                            print(error.localizedDescription)
                        case .custom(let message):
                            print("END TRIP : " + message)
                        default:
                            print("DEBUG: End Trip(1) - " + error.localizedDescription)
                        }
                        completion(false)
                    }
                }
            case .failure(let error):
                switch error {
                case .noInternetConnection:
                    print(error.localizedDescription)
                case .custom(let message):
                    print("ACTIVE BOOKING : " + message)
                default:
                    print("DEBUG: End Trip(2) - " + error.localizedDescription)
                }
                completion(false)
            }
        }
    }
}
