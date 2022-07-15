import Foundation
import Combine
import UIKit

class MealAPI {
    
    public static let shared = MealAPI()
    
    func fetchAllMeals(offset: Int, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }

        let json: [String: Any] = ["Contains": ""]
        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchFirstCategoriesMeals(completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }

        let json: [String: Any] = ["CategoryName": "салаты"]
        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchSecondCategoriesMeals(completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }

        let json: [String: Any] = ["CategoryName": "десерты"]
        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchThirdsCategoriesMeals(completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }

        let json: [String: Any] = ["CategoryName": "горячие супы"]
        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchPopularMeals(offset: Int, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        let json: [String: Any] = ["IsPopular": true, "Limit": 10, "Offset": offset,]

        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchRecWithoutToekenMeals(completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        //:TODO: API 2.0
        guard let url = URL(string: MealAPIConsts.URLStringRecWithoutTokenMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
//        mealsSession(url: url, completion: completion)
    }
    
    func fetchMealWithIngredients(offset: Int, searchString: String, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        //TODO: Add offset
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        let json: [String: Any] = ["Ingredients": searchString.components(separatedBy: ","), "Limit": 30]
        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func fetchMealWithSearch(offset: Int, searchString: String, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        //TODO: Add offset job
        guard let url = URL(string: MealAPIConsts.URLStringAllMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        var json: [String: Any] = [:]
        
        if searchString.isEmpty {
            json = ["IsPopular": true, "Limit": 30]
        } else {
            json = ["Contains": searchString, "Limit": 30]
        }
        mealsPostSession(jsonBody: json, url: url, completion: completion)
    }
    
    func mealsPostSession(jsonBody: [String: Any], url: URL, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
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
                    let response = try JSONDecoder().decode(MealResponse.self, from: data)
                    completion(.success(response.response ?? []))
                } catch let error as NSError {
                    
                    print(data.printJSON())
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MyError.format))
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    //TODO: fix rec meals
    func fetchRecMeals(completion: @escaping ((Result<LikesRecModel, Error>) -> Void)) {
        guard let token = AuthService.token else {
            print("fetchRecMeals, cannot find token" )
            return
        }
        
        guard let url = URL(string: MealAPIConsts.URLStringRecMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("escapp.icyftl.ru", forHTTPHeaderField: "Host")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(LikesRecModel.self, from: data)
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
    
}

struct MealAPIConsts {
    static let URLStringRecMeal = "https://escapp.icyftl.ru/user/recommend?number_of_items=40"
    static let URLStringRecWithoutTokenMeal = "https://escapp.icyftl.ru/recipes/get?is_popular=true&limit=50"
    static let URLStringAllMeal = "https://escapp-stage.icyftl.xyz/api/v2/recipes/get"
}
