//
//  IngredientAPI.swift
//  eah
//
//  Created by Danil Ilichev on 02.07.2022.
//

import Foundation

class IngredientAPI {
    
    public static let shared = IngredientAPI()
    
    func fetchAllIngredients(completion: @escaping ((Result<[Ingredient], Error>) -> Void)) {
        guard let url = URL(string: IngredientAPIConsts.URLStringIngredient) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        let json: [String: Any] = ["IsFavorite": true, "Limit": 72]
        ingredientsSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchMealWithSearch(searchString: String, completion: @escaping ((Result<[Ingredient], Error>) -> Void)) {
        guard let url = URL(string: IngredientAPIConsts.URLStringIngredient) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        let json: [String: Any] = ["Contains": searchString, "Limit": 30]
        ingredientsSession(jsonBody: json, url: url, completion: completion)
    }
        
    func ingredientsSession(jsonBody: [String: Any], url: URL, completion: @escaping ((Result<[Ingredient], Error>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
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
    
struct IngredientAPIConsts {
    static let URLStringIngredient = "https://escapp-stage.icyftl.xyz/api/v2/ingredients/get"
}
