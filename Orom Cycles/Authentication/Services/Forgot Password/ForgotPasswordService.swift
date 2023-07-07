//
//  ForgotPasswordService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation

extension APIService {
    
    /// Forgot Password Error type.
    /// Contains errors related to Forgot Password
    enum ForgorPasswordError: Error {
        case invalid
        case custom(message: String)
    }
    
    /// The request body for the Forgot Password API
    struct ForgotPasswordRequestBody: Codable {
        var email: String
    }
    
    /// The structure of the response from SignUp API
    struct ForgotPasswordResponseBody: Codable {
        var status: String
        var message: String
    }
    
    /// SignUp Function
    /// - Parameter email : email of the user
    /// - Parameter completion : Operation to do with the Result received. Result : success -> gives message | failure -> gives ForgorPasswordError
    func forgotPassword(email: String, completion: @escaping (Result<String, ForgorPasswordError>) -> Void) {
        
        guard let url = URL(string: FORGOT_PASSWORD_URL) else {
            completion(.failure(.custom(message: "Invalid Forgot password URL")))
            print("Invalid Forgot password Url")
            return
        }
        
        let body = ForgotPasswordRequestBody(email: email)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.custom(message: String(describing: error))))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.invalid))
                    return
                }
                
                guard let forgotPasswordResponse = try? JSONDecoder().decode(ForgotPasswordResponseBody.self, from: data) else {
                    completion(.failure(.custom(message: "Unable to decode Forgot password response")))
                    return
                }
                
                completion(.success(forgotPasswordResponse.message))
            }.resume()
        }
    }
}
