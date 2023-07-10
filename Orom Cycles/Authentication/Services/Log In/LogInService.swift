//
//  LogInService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation

extension APIService {
    /// Login Errors
    enum LoginError: Error {
        case noInternetConnection
        case invalidEmailPassword
        case custom(errorMessage: String)
    }
    
    /// Login URL request body
    private struct LoginRequestBody: Codable {
        let email: String
        let password: String
    }
    
    /// Login API response structure
    private struct LoginResponse: Codable {
        let status: String
        let token: String?
    }
    
    /// Login Function
    /// - Parameter email : email of the user
    /// - Parameter password : password of the user
    /// - Parameter completion : Operation to do with the Result received. Result : success -> gives JWT | failure -> gives LoginError
    func login(email: String, password: String, completion: @escaping (Result<String, LoginError>) -> Void) {
        
        guard let url = URL(string: LOGIN_URL) else {
            completion(.failure(.custom(errorMessage: "Invalid Login Url")))
            print("Invalid Login Url")
            return
        }

        let body = LoginRequestBody(email: email, password: password)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)

        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    print("NO INTERNET CONNECTION")
                    return
                }

                guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.invalidEmailPassword))
                    print("INVALID EMAIL")
                    return
                }

                guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data),
                      let jwt = loginResponse.token else {
                    completion(.failure(.custom(errorMessage: "Unable to decode SignUp response")))
                    return
                }

                completion(.success(jwt))
            }.resume()
        }
    }
}
