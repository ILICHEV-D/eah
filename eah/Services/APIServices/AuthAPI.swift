//
//  AuthAPI.swift
//  eah
//
//  Created by Danil Ilichev on 22.11.2021.
//


import Foundation
import UIKit
import SwiftUI

// MARK: - Consts

struct Consts {
    static let URLStringSignUp = "https://escapp.icyftl.ru/user/register"
    static let URLStringSignIn = "https://escapp.icyftl.ru/user/login"
    static let URLStringLike = "https://escapp.icyftl.ru/recipes/like"
    static let URLStringUnlike = "https://escapp.icyftl.ru/recipes/unlike"
    static let URLStringLikes = "https://escapp.icyftl.ru/user/likes"
    static let URLStringMealFromUid = "https://escapp.icyftl.ru/recipes/get/"
}


// MARK: - Network

public final class AuthApi {
    static func sendRequestSignIn(login: String, password: String, completion: @escaping ((Result<AuthModel, Error>) -> Void)) {
        let urlString = Consts.URLStringSignIn
        guard let url = URL(string: urlString) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let json: [String: Any] = ["email": "\(login)", "password": "\(password)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(AuthModel.self, from: data)
                    completion(.success(response))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
    
    static func sendRequestSignUp(login: String, password: String, age: Int?, sex: Bool?, name: String, completion: @escaping ((Result<AuthSimpleResponse, Error>) -> Void)) {
        let urlString = Consts.URLStringSignUp
        guard let url = URL(string: urlString) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var json: [String: Any] = [:]
        if age != nil && age != nil {
            json = ["Email": "\(login)", "Password": "\(password)", "FirstName": "\(name)"]
        } else {
            json = ["Email": "\(login)", "Password": "\(password)", "FirstName": "\(name)", "Sex": sex!, "Age": age!]
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(AuthSimpleResponse.self, from: data)
                    completion(.success(response))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
    
    static func sendLike(recipeUid: String, completion: @escaping ((Result<AuthSimpleResponse, Error>) -> Void)) {
        
        guard let url = URL(string: "\(Consts.URLStringLike)?recipe_uid=\(recipeUid)") else {
            completion(.failure(MyError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.addValue("escapp.icyftl.ru", forHTTPHeaderField: "Host")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(AuthService.token!)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(AuthSimpleResponse.self, from: data)
                    completion(.success(response))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
    
    static func sendUnlike(recipeUid: String, completion: @escaping ((Result<AuthSimpleResponse, Error>) -> Void)) {
        
        guard let url = URL(string: "\(Consts.URLStringUnlike)?recipe_uid=\(recipeUid)") else {
            completion(.failure(MyError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        request.addValue("escapp.icyftl.ru", forHTTPHeaderField: "Host")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(AuthService.token!)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(AuthSimpleResponse.self, from: data)
                    completion(.success(response))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
    
    static func getLikes(completion: @escaping ((Result<LikesModel, Error>) -> Void)) {
        guard let url = URL(string: Consts.URLStringLikes) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("escapp.icyftl.ru", forHTTPHeaderField: "Host")
        request.setValue( "Bearer \(AuthService.token!)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(LikesModel.self, from: data)
                    completion(.success(response))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
    
    
    static func getMealFromUid (uid: String, completion: @escaping ((Result<Meal, Error>) -> Void)) {
        guard let url = URL(string: Consts.URLStringMealFromUid + uid) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(MealResponse.self, from: data)
                    if let meal = response.response?[0] {
                        completion(.success(meal))
                    }
                } catch let error as NSError {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
}
