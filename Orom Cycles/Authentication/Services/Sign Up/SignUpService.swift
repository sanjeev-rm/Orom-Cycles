//
//  SignUpService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation

extension AuthenticationAPIService {
    
    /// SignUp Error type.
    /// Contains errors related to SignUp
    enum SignUpError: Error {
        case noInternetConnection
        case userAlreadyExists
        case emailOrServerError
        case custom(errorMessage: String)
    }
    
    /// The request body for the SignUp API
    private struct SignUpRequestBody: Codable {
        let name: String
        let email: String
        let password: String
        let passwordConfirm: String
    }
    
    /// The structure of the response from SignUp API
    private struct SignUpResponse: Codable {
        let status: String
        let message: String
    }
    
    /// SignUp Function
    /// - Parameter name : name of the user
    /// - Parameter email : email of the user
    /// - Parameter completion : Operation to do with the Result received. Result : success -> gives message | failure -> gives SignUpError
    func signUp(name: String, email: String, password: String, passwordConfirm: String,
                completion: @escaping (Result<String, SignUpError>) -> Void) {
        
        guard let url = URL(string: SIGN_UP_URL) else {
            completion(.failure(.custom(errorMessage: "Invalid SignUp Url")))
            print("Invalid Sign-Up Url")
            return
        }
        
        let body = SignUpRequestBody(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
                    guard let httpUrlResponse = response as? HTTPURLResponse else {
                        completion(.failure(.custom(errorMessage: "Unidentified Error")))
                        return
                    }
                    switch httpUrlResponse.statusCode {
                    case 400:
                        completion(.failure(.userAlreadyExists))
                    case 500:
                        completion(.failure(.emailOrServerError))
                    default:
                        completion(.failure(.custom(errorMessage: "Unidentified Error")))
                    }
                    return
                }
                
                guard let signUpResponse = try? JSONDecoder().decode(SignUpResponse.self, from: data) else {
                    completion(.failure(.custom(errorMessage: "Unable to decode SignUp response")))
                    return
                }
                
                completion(.success(signUpResponse.message))
            }.resume()
        }
    }
}
