//
//  AuthService.swift
//  eah
//
//  Created by Danil Ilichev on 02.07.2022.
//

import Foundation
import UIKit

public final class AuthService {
    
    public static let shared = AuthService()

    static var userImage: UIImage? = UIImage(named: "profile") {
        didSet {print("changeImage")}
    }
    
    static var token: String? {
        didSet {print(token ?? "")}
    }
    
    static var refreshToken: String? {
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
    
    private static func saveRefreshToken(token: String?) {
        UserDefaults.standard.set(token, forKey:"refreshToken")
        loadRefreshToken()
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
    
    static func loadToken() {
        if let tokenFromUD = UserDefaults.standard.value(forKey:"token") as? String {
            self.token = tokenFromUD
            print(token)
        }
        else {
            print("Пользователь не авторизован")
        }
    }
    
    static func loadRefreshToken() {
        if let tokenFromUD = UserDefaults.standard.value(forKey:"refreshToken") as? String {
            self.refreshToken = tokenFromUD
            print(refreshToken)
        }
        else {
            print("refreshToken. Пользователь не авторизован")
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
    
    static func saveAll(token: String, refreshToken: String, name: String, age: Int, sex: Bool){
        saveName(name: name)
        saveSex(sex: sex)
        saveAge(age: age)
        saveToken(token: token)
        saveRefreshToken(token: refreshToken)
    }
    
    static func deleteAll() {
        saveToken(token: nil)
        saveAge(age: nil)
        saveName(name: nil)
        saveSex(sex: nil)
        saveToken(token: nil)
        saveRefreshToken(token: nil)
    }
    
}
