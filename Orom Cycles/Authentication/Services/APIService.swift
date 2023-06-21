//
//  APIService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 19/06/23.
//

import Foundation
import SwiftUI

/// Class responsible for APIService functions
class APIService {
    
    static let shared = APIService()
    
    // MARK: - SignUp
    
    /// SignUp Error type. Contains errors related to SignUp
    enum SignUpError: Error {
        case userAlreadyExists
        case emailOrServerError
        case custom(errorMessage: String)
    }
    
    /// The request body for the SignUp API
    struct SignUpRequestBody: Codable {
        let name: String
        let email: String
        let password: String
        let passwordConfirm: String
    }
    
    /// The structure of the response from SignUp API
    struct SignUpResponse: Codable {
        let status: String
        let message: String
    }
    
    /// Sign Up URL
    private final var SIGN_UP_URL = "https://geoapi-production-8c7a.up.railway.app/api/v1/users/signup"
    
    /// SignUp function
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
                    completion(.failure(.custom(errorMessage: String(describing: error))))
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
    
    
    
    
   
    // MARK: - Login
    
    /// Login Errors
    enum LoginError: Error {
        case invalidEmailPassword
        case custom(errorMessage: String)
    }
    
    /// Login URL request body
    struct LoginRequestBody: Codable {
        let email: String
        let password: String
    }
    
    /// Login API response structure
    struct LoginResponse: Codable {
        let status: String
        let token: String?
    }
    
    /// The Login API URL in string
    private var LOGIN_URL: String = "https://geoapi-production-8c7a.up.railway.app/api/v1/users/login"
    
    /// Login Function
    /// - Parameter email : email of the user
    /// - Parameter password : password of the user
    /// - Parameter completion : Operation to do with the Result received. Result : success -> gives JWT / failure -> gives LoginError
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
                    completion(.failure(.custom(errorMessage: String(describing: error))))
                    return
                }

                guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
                    completion(.failure(.invalidEmailPassword))
                    return
                }

                guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion(.failure(.custom(errorMessage: "Unable to decode SignUp response")))
                    return
                }

                completion(.success(loginResponse.token!))
            }.resume()
        }
    }
}
