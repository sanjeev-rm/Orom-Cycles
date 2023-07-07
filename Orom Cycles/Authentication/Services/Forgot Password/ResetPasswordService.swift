//
//  VerificationAndNewPasswordService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 06/07/23.
//

import Foundation

extension APIService {
    
    enum ResetPasswordError: Error {
        case incorrectOtp
        case passwordsDontMatch
        case custom(_ message: String)
    }
    
    struct ResetPasswordRequestBody: Codable {
        var email: String
        var password: String
        var passwordConfirm: String
        var otp: String
    }
    
    struct ResetPasswordResponseBody: Codable {
        var status: String
    }
    
    func resetPassword(email: String, password: String, passwordConfirm: String, otp: String,
                       completion: @escaping (Result<String, ResetPasswordError>) -> Void) {
        
        guard let url = URL(string: RESET_PASSWORD_URL) else {
            completion(.failure(.custom("Invalid Reset password URL")))
            print("Invalid Reset password URL")
            return
        }
        
        let body = ResetPasswordRequestBody(email: email, password: password, passwordConfirm: passwordConfirm, otp: otp)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(.custom(String(describing:error))))
                               return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    if let httpUrlResponse = response as? HTTPURLResponse {
                        switch httpUrlResponse.statusCode {
                        case 400:
                            completion(.failure(.incorrectOtp))
                        case 500:
                            completion(.failure(.passwordsDontMatch))
                        default:
                            completion(.failure(.custom("Unidentified Error")))
                        }
                    }
                    return
                }
                
                guard let resetPasswordResponse = try? JSONDecoder().decode(ResetPasswordResponseBody.self, from: data) else {
                    completion(.failure(.custom("Unable to decode Reset password response")))
                    return
                }
                
                completion(.success(resetPasswordResponse.status))
            }.resume()
        }
    }
}
