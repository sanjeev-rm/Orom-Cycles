//
//  ProfileService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 03/08/23.
//

import Foundation

extension DashboardAPIService {
    
    enum UserInfoError: Error {
        case noInternetConnection
        case custom(message: String)
    }
    
    struct UserInfoResponse: Codable {
        let status: String
        let userData: UserData
    }
    
    struct UserData: Codable {
        let info: Info
    }
    
    struct Info: Codable {
        let role: String
        let verified: Bool
        let balance: Int
        let name: String
        let email: String
    }
    
    func getUserInfo(completion: @escaping (Result<UserInfoResponse, UserInfoError>) -> Void) {
        
        let urlString = DashboardAPIService.USER_INFO_URL
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(message: "Invalid User Info URL")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(Storage.jsonWebToken ?? "")", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) {data, response, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.custom(message: "Invalid JWT || Some Error")))
                    return
                }
                
                guard let userInfoResponse = try? JSONDecoder().decode(UserInfoResponse.self, from: data) else {
                    completion(.failure(.custom(message: "Unable to decode User Info Response")))
                    return
                }
                
                completion(.success(userInfoResponse))
            }.resume()
        }
    }
}
