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

// MARK: - MyError

enum MyError: Error {
    case format
    case decode
    case invalidURL
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .format:
            return "Received neither error nor data"
        case .decode:
            return "Got data in unexpected format, it might be error description"
        case .invalidURL:
            return "URL is incorrect :("
        }
    }
}

// MARK: - AuthAPI

public final class AuthApi {

    static var userImage: UIImage? = UIImage(named: "profile") {
        didSet {print("changeImage")}
    }
    
    static var token: String? {
        didSet {print(token ?? "")}
    }
    
    static var name: String? {
        didSet {print(name ?? "")}
    }
    
    static var age: String? {
        didSet {print(age ?? "")}
    }
    
    static var sex: String? {
        didSet {print(sex ?? "")}
    }
    
    private static func saveToken(token: String?) {
        UserDefaults.standard.set(token, forKey:"token")
        loadToken()
    }
    
    private static func saveName(name: String?) {
        UserDefaults.standard.set(name, forKey:"name")
        loadName()
    }
    
    private static func saveSex(sex: Bool?) {
        UserDefaults.standard.set(sex, forKey:"sex")
        loadSex()
    }
    
    private static func saveAge(age: Int?) {
        UserDefaults.standard.set(age, forKey:"age")
        loadAge()
    }
    
    static func saveUserImage(image: UIImage) {
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: "userImage")
            print("Изображение профиля сохранено")
            loadUserImage()
        }
    }
    
    static func goToTelegram() {
        let appURL = NSURL(string: "tg://resolve?domain=eahapp")!
        let webURL = NSURL(string: "https://t.me/eahapp")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    static func goToInstagram() {
        let appURL = URL(string: "instagram://user?username=eahapp")!
        let webURL = URL(string: "https://instagram.com/eahapp")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    static func loadToken() {
        if let tokenFromUD = UserDefaults.standard.value(forKey:"token") as? String {
            self.token = tokenFromUD
        }
        else {
            print("Пользователь не авторизован")
        }
    }
    
    static func loadUserImage() {
        if let imageData = UserDefaults.standard.object(forKey: "userImage") as? Data {
           self.userImage = UIImage(data: imageData)
            print("Изображение профиля загружено")
        }
    }
    
    
    static func loadName() {
        if let nameFromUD = UserDefaults.standard.value(forKey:"name") as? String {
            self.name = nameFromUD
        }
        else {
            print("name не авторизован")
        }
    }
    
    static func loadAge() {
        if let ageFromUD = UserDefaults.standard.value(forKey:"age") as? String {
            self.age = ageFromUD
        }
        else {
            print("Age не авторизован")
        }
    }
    
    static func loadSex() {
        if let sexFromUD = UserDefaults.standard.value(forKey: "sex") as? String {
            self.sex = sexFromUD
        }
        else {
            print("sex не авторизован")
        }
    }
    
    static func saveAll(token: String, name: String, age: Int, sex: Bool){
        saveName(name: name)
        saveSex(sex: sex)
        saveAge(age: age)
        saveToken(token: token)
    }
    
    static func deleteAll() {
        saveToken(token: nil)
        saveAge(age: nil)
        saveName(name: nil)
        saveSex(sex: nil)
        token = nil
    }
    

}


// MARK: - Network

extension AuthApi {
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
    
    static func sendRequestSignUp(login: String, password: String, age: Int, sex: Bool, name: String, completion: @escaping ((Result<AuthSimpleResponse, Error>) -> Void)) {
        let urlString = Consts.URLStringSignUp
        guard let url = URL(string: urlString) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let json: [String: Any] = ["Email": "\(login)", "Password": "\(password)", "FirstName": "\(name)", "Sex": sex, "Age": age]
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
        request.setValue( "Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
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
        request.setValue( "Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
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
            request.setValue( "Bearer \(token!)", forHTTPHeaderField: "Authorization")
    
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
//                        print(response.response)
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
