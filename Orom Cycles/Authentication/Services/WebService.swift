//
//  WebService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 19/06/23.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct Credentials: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    var jwt: String
    var message: String
    var success: Bool
}

class WebService {
    
    func login(credentials: Credentials,
               completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(credentials)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let error = error else {
                completion(.failure(.custom(errorMessage: error!.localizedDescription)))
                return
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse,
                  httpUrlResponse.statusCode == 200 else {
                completion(.failure(.custom(errorMessage: "Server error")))
                return
            }
            
            guard let data = data,
                  let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
        }
    }
}
