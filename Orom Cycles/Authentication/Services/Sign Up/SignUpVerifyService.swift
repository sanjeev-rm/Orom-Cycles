//
//  SignUpVerifyService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation

extension AuthenticationAPIService {
    
    /// SignUp Verify Errors
    enum SignUpVerifyError: Error {
        case noInternetConnection
        case invalidOtp
        case custom(errorMessage: String)
    }
    
    /// The request body for the SignUp verify API
    private struct SignUpVerifyBody: Codable {
        var email: String
        var otp: String
    }
    
    /// The structure of the response from SignUp verify API
    private struct SignUpVerifyResponse: Codable {
        var status: String
        /// Only included in the response when the status is success
        /// The JWT of the user
        var token: String?
    }
    
    /// Login Function
    /// - Parameter email : email of the user
    /// - Parameter otp : otp of the user
    /// - Parameter completion : Operation to do with the Result received. Result : success -> gives JWT | failure -> gives SignUpVerifyError
    func signUpVerifyOtp(email: String, otp: String,
                         completion: @escaping (Result<String, SignUpVerifyError>) -> Void) {
        
        guard let url = URL(string: SIGN_UP_VERIFY_URL) else {
            completion(.failure(SignUpVerifyError.invalidOtp))
            return
        }
        
        let body = SignUpVerifyBody(email: email, otp: otp)
        
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
                
                guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode != 400 else {
                    completion(.failure(.invalidOtp))
                    return
                }
                
                guard let signUpVerifyResponse = try? JSONDecoder().decode(SignUpVerifyResponse.self, from: data),
                      let jwt = signUpVerifyResponse.token else {
                    completion(.failure(.custom(errorMessage: "Unable to decode SignUpVerify response")))
                    return
                }
                
                completion(.success(jwt))
            }.resume()
        }
    }
}
