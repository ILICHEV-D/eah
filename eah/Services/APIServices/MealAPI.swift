import Foundation
import Combine
import UIKit

class MealAPI {
    
    public static let shared = MealAPI()
    
    func fetchAllMeals(offset: Int, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: Consts.URLStringAllMeal + "&limit=\(10)&offset=\(offset)") else {
            completion(.failure(MyError.invalidURL))
            return
        }

        mealsSession(url: url, completion: completion)
    }
    
    func fetchPopularMeals(offset: Int, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: Consts.URLStringPopularMeal + "&limit=\(10)&offset=\(offset)") else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        mealsSession(url: url, completion: completion)
    }
    
    func fetchRecWithoutToekenMeals(completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        guard let url = URL(string: Consts.URLStringRecWithoutTokenMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        mealsSession(url: url, completion: completion)
    }
    
    func fetchMealWithIngredients(offset: Int, searchString: String, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        //TODO: Add offset job
        guard let url = URL(string: Consts.URLStringAllMeal + ("&ingredients=\(searchString ?? "")&limit=30").encodeUrl) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        mealsSession(url: url, completion: completion)
    }
    
    func fetchMealWithSearch(offset: Int, searchString: String, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        //TODO: Add offset job
        guard let url = URL(string: Consts.URLStringAllMeal + ("&startswith=\(searchString ?? "")&limit=30").encodeUrl) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        mealsSession(url: url, completion: completion)
    }
    
    
    func mealsSession(url: URL, completion: @escaping ((Result<[Meal], Error>) -> Void)) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(MealResponse.self, from: data)
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
    
    func fetchRecMeals(completion: @escaping ((Result<LikesRecModel, Error>) -> Void)) {
        guard let token = AuthApi.token else {
            print("fetchRecMeals, cannot find token" )
            return
        }
        
        guard let url = URL(string: Consts.URLStringRecMeal) else {
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
