//
//  ProfileService.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 03/08/23.
//

import Foundation

extension DashboardAPIService {
    
    // MARK: - Get User Info
    
    enum UserInfoError: Error {
        case noInternetConnection
        case custom(message: String)
    }
    
    struct UserInfoResponse: Codable {
        let status: String
        let token: String?
        let userData: UserData
        
        enum CodingKeys: String, CodingKey {
            case status
            case token
            case userData = "data"
        }
    }
    
    struct UserData: Codable {
        let info: Info
        
        enum CodingKeys: String, CodingKey {
            case info = "user"
        }
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
    
    
    
    // MARK: - Update Name
    
    struct UpdateNameRequestBody: Codable {
        let name: String
    }
    
    func updateName(name: String, completion: @escaping (Result<UserInfoResponse, UserInfoError>) -> Void) {
        let urlString = DashboardAPIService.UPDATE_NAME_URL
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(message: "Invalid Update name URL")))
            return
        }
        
        let body = UpdateNameRequestBody(name: name)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
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
                
                guard let updatedUserInfoResponse = try? JSONDecoder().decode(UserInfoResponse.self, from: data) else {
                    completion(.failure(.custom(message: "Unable to decode Update Name User Info response")))
                    return
                }
                
                completion(.success(updatedUserInfoResponse))
            }.resume()
        }
    }
    
    
    
    // MARK: - Update Password
    
    struct UpdatePasswordRequestBody: Codable {
        let passwordCurrent: String
        let password: String
        let passwordConfirm: String
    }
    
    func updatePassword(passwordCurrent: String, newPassword: String, confirmNewPassword: String,
                        completion: @escaping (Result<String, UserInfoError>) -> Void) {
        
        let urlString = DashboardAPIService.UPDATE_PASSWORD_URL
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(message: "Invalid Update Password URL")))
            return
        }
        
        let body = UpdatePasswordRequestBody(passwordCurrent: passwordCurrent, password: newPassword, passwordConfirm: confirmNewPassword)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        urlRequest.setValue("Bearer \(Storage.jsonWebToken ?? "")", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.noInternetConnection))
                    return
                }
                
                guard let httpUrlResposne = response as? HTTPURLResponse,
                      httpUrlResposne.statusCode == 200 else {
                    completion(.failure(.custom(message: "Invalid JWT || Some Error")))
                    return
                }
                
                guard let updatedPasswordUserInfo = try? JSONDecoder().decode(UserInfoResponse.self, from: data) else {
                    completion(.failure(.custom(message: "Unable to decode Updated Password User Info")))
                    return
                }
                
                guard let token = updatedPasswordUserInfo.token else {
                    completion(.failure(.custom(message: "Unable to get the token")))
                    return
                }
                
                completion(.success(token))
            }.resume()
        }
    }
}
