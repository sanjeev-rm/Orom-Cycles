//
//  TripService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 02/08/23.
//

import Foundation

extension DashboardAPIService {
    
    enum TripError: Error {
        case custom(message: String)
        case noInternetConnection
        case insufficientFunds
    }
    
    // MARK: - Start Ride
    
    /// Function to start ride on a cycle
    func startRide(cycleId: String, completion: @escaping (Result<String, TripError>) -> Void) {
        
        let urlString = DashboardAPIService.get_START_RIDE_URL_OF_CYCLE(cycleId: cycleId)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(message: "Invalid Start Ride URL")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(Storage.jsonWebToken ?? "")", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { _, response, error in
                
                guard error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode != 400 else {
                    completion(.failure(.custom(message: "Invalid JWT || Some Error")))
                    return
                }
                
                completion(.success("Ride has began"))
            }.resume()
        }
    }
    
    // MARK: - Active Booking (Ride)
    
    struct GetActiveBookingResponse: Codable {
        let status: String
        let data: ActiveBookingData
    }
    
    struct ActiveBookingData: Codable {
        let cycleId: String
        let bookingId: String
        
        enum CodingKeys: String, CodingKey {
            case cycleId = "cycle"
            case bookingId = "_id"
        }
    }
    
    /// Function to get the current active booking
   func getActiveBooking(completion: @escaping (Result<GetActiveBookingResponse, TripError>) -> Void) {
        
        let urlString = DashboardAPIService.GET_ACTIVE_BOOKING_URL
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(message: "Invalid Get Active Booking URL")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(Storage.jsonWebToken ?? "")", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.custom(message: "Invalid JWT || No Active booking")))
                    return
                }
                
                guard let getActiveBookingResponse = try? JSONDecoder().decode(GetActiveBookingResponse.self, from: data) else {
                    completion(.failure(.custom(message: "Unable to decode Get Active Booking response")))
                    return
                }
                
                completion(.success(getActiveBookingResponse))
            }.resume()
        }
    }
    
    // MARK: - End Ride
    
    struct EndRideResponse: Codable {
        let status: String
        let cost: Double
    }
    
    func endRide(bookingId: String, completion: @escaping (Result<EndRideResponse, TripError>) -> Void) {
        let urlString = DashboardAPIService.get_END_RIDE_URL(bookingId: bookingId)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(message: "Invalid End Trip URL")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("Bearer \(Storage.jsonWebToken ?? "")", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.custom(message: "Invalid JWT || Some Error")))
                    return
                }
                
                guard let endRideResponse = try? JSONDecoder().decode(EndRideResponse.self, from: data) else {
                    completion(.failure(.custom(message: "Unable to decode End Ride response")))
                    return
                }
                
                completion(.success(endRideResponse))
            }.resume()
        }
    }
}
