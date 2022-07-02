import Foundation
import Combine
import UIKit


enum Endpoint {
    
    case allIngredients(limit: Int)
    case searchIngredients (limit: Int, searchString: String?)
    case mealWithIngredients (limit: Int, searchString: String?)
    
    init? (index: Int, limit: Int) {
        switch index {
        case 4: self = .searchIngredients(limit: limit, searchString: nil)
        case 5: self = .allIngredients(limit: limit)
        default: return nil
        }
    }
    
    private var baseURL: URL {URL(string: "https://escapp.icyftl.ru/")!}
    private var baseString: String {"https://escapp.icyftl.ru/"}
    
    private func path() -> String {
        switch self {
        case .searchIngredients(_, let searchString):
            return "ingredients/get?startswith=\(searchString ?? "")"
        case .allIngredients:
            return "ingredients/get?is_favorite=true&limit=72"
        case .mealWithIngredients(_, let searchString):
            return "recipes/get?ingredients=\(searchString ?? "")&limit=60"
        }
    }
    
    
    private func limitURL (baseURL: URL) -> URL {
        switch self {
        case let .searchIngredients(limit, searchString):
            if limit > 1 {
                return  URL(string: baseString + "ingredients/get?startswith=\(searchString ?? "")")!}
            else {return baseURL}
            
        case let .allIngredients(limit):
            if limit > 1 {
                return  URL(string: baseString + "ingredients/get?is_favorite=true&limit=30")!}
            else {return baseURL}
            
        case let .mealWithIngredients(limit, searchString):
            return baseURL
        }
    }
    
    private func getLimit () -> Int {
        switch self {
        case .allIngredients(limit: let limit):
            return limit
        case let .searchIngredients(limit, _):
            return limit
        case let .mealWithIngredients(limit, _):
            return limit
        }
    }
    
    var absoluteURL: URL? {
        var queryURL = URL(string: baseURL.appendingPathComponent(self.path().encodeUrl).absoluteString.removingPercentEncoding!)
        queryURL = limitURL(baseURL: queryURL!)
        return queryURL
    }
}

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
    
    func fetchIngredients(from endpoint: Endpoint) -> AnyPublisher<[Ingredient], Never> {
        guard let url = endpoint.absoluteURL else {
            return Just([Ingredient]()).eraseToAnyPublisher() // 0
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: IngredientResponse.self, decoder: JSONDecoder())
            .map {$0.response!}
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
