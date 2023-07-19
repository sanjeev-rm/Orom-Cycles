//
//  MapService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 18/07/23.
//

import Foundation
import MapKit

extension DashboardAPIService {
    
    enum MapError: Error {
        case noInternetConnection
        case custom(errorMessage: String)
    }
    
    // MARK: - Model for response from API
    
    private struct MapResponseBody: Codable {
        let status: String
        let results: Int
        let cycles: Cycles
        
        enum CodingKeys: String, CodingKey {
            case status
            case results
            case cycles = "data"
        }
    }
    
    struct Cycles: Codable {
        let cycles: [Cycle]
        
        enum CodingKeys: String, CodingKey {
            case cycles = "data"
        }
    }
    
    struct Cycle: Codable {
        let _id: String
        let location: Location
        let createdAt: String//
        let available: Bool
        let name: String
        let slug: String
        let __v: Int
    }
    
    struct Location: Codable {
        let type: String
        let coordinates: [Double]
    }
    
    // MARK: - Function
    
    func getCycles(radius: Int, latitude: Double, longitude: Double, completion: @escaping (Result<Cycles, MapError>) -> Void) {
        
        let urlString = CYCLES_NEAR_ME_URL + "\(radius)/center/\(latitude),\(longitude)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(errorMessage: "Invalid Cycles URL")))
            print("Invalid Cycles URL");
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(Storage.jsonWebToken ?? "")", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                print("\n\n***********ONE***********\n\n")
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                print("\n\n***********TWO***********\n\n")
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.custom(errorMessage: "Invalid JWT || Some Error")))
                    return
                }
                
                print("\n\n***********THREE***********\n\n")
                
                guard let mapResponse = try? JSONDecoder().decode(MapResponseBody.self, from: data) else {
                    completion(.failure(.custom(errorMessage: "Unable to decode Map Response")))
                    return
                }
                
                print("\n\n***********FOUR***********\n\n")
                
                completion(.success(mapResponse.cycles))
            }.resume()
        }
    }
}
