//
//  IngredientAPI.swift
//  eah
//
//  Created by Danil Ilichev on 02.07.2022.
//

import Foundation

class IngredientAPI {
    
    public static let shared = IngredientAPI()
    
    static let URLStringIngredient = "https://escapp.icyftl.ru/ingredients/"
//    "ingredients/get?is_favorite=true&limit=72"
    
    func fetchAllIngredients(completion: @escaping ((Result<[Ingredient], Error>) -> Void)) {
        guard let url = URL(string: IngredientAPI.URLStringIngredient + "get?is_favorite=true&limit=72") else {
            completion(.failure(MyError.invalidURL))
            return
        }
        ingredientsSession(url: url, completion: completion)
    }
    
    func fetchMealWithSearch(searchString: String, completion: @escaping ((Result<[Ingredient], Error>) -> Void)) {
        guard let url = URL(string: IngredientAPI.URLStringIngredient + ("get?startswith=\(searchString)&limit=30").encodeUrl) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        print(url)
        ingredientsSession(url: url, completion: completion)
    }
        
    func ingredientsSession(url: URL, completion: @escaping ((Result<[Ingredient], Error>) -> Void)) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(IngredientResponse.self, from: data)
                    completion(.success(response.response ?? []))
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
    
