import Foundation
import Combine
import UIKit


enum Endpoint {
    
    case all(limit: Int)
    case rec(limit: Int)
    case popular(limit: Int)
    case allIngredients(limit: Int)
    case search (limit: Int, searchString: String?)
    case searchIngredients (limit: Int, searchString: String?)
    case mealWithIngredients (limit: Int, searchString: String?)
    
    init? (index: Int, limit: Int) {
        switch index {
        case 0: self = .all(limit: limit)
        case 1: self = .rec(limit: limit)
        case 2: self = .popular(limit: limit)
        case 3: self = .search(limit: limit, searchString: nil)
        case 4: self = .searchIngredients(limit: limit, searchString: nil)
        case 5: self = .allIngredients(limit: limit)
        case 6: self = .mealWithIngredients(limit: limit, searchString: nil)
        default: return nil
        }
    }
    
    private var baseURL: URL {URL(string: "https://escapp.icyftl.ru/")!}
    private var baseString: String {"https://escapp.icyftl.ru/"}
    
    private func path() -> String {
        switch self {
        case .all:
            return "recipes/get"
        case .rec:
            return "user/recommend?number_of_items=10"
        case .popular:
            return "recipes/get?is_popular=true"
        case .search(_, let searchString):
            return "recipes/get?startswith=\(searchString ?? "")&limit=30"
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
        case let .all(limit):
            if limit > 1 {
                return URL(string: baseString + "recipes/get?limit=\(10)&offset=\(limit)")!}
            else {return baseURL}
            
        case let .rec(limit):
            if limit > 1 {
                print(limit)
                return  URL(string: baseString + "user/recommend?number_of_items=10")!}
            else {return baseURL}
            
        case let .popular(limit):
            if limit > 1 {
                return  URL(string: baseString + "recipes/get?limit=\(10)&offset=\(limit)&is_popular=true")!}
            else {return baseURL}
            
        case let .search(limit, _):
            if limit > 1 {
                return baseURL.appendingPathComponent("&limit=30")
            }
            else {return baseURL}
            
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
            
            //            if limit > 1 {
            //                print(URL(string: baseString + "recipes/get?limit=\(10)&offset=\(limit)&ingredients=\(searchString ?? "")")!)
            //                return  URL(string: baseString + "recipes/get?limit=\(10)&offset=\(limit)&ingredients=\(searchString ?? "")")!}
            //            else {return baseURL}
        }
    }
    
    private func getLimit () -> Int {
        switch self {
        case let .all(limit):
            return limit
        case let .rec(limit):
            return limit
        case let .popular(limit):
            return limit
        case .allIngredients(limit: let limit):
            return limit
        case let .search(limit, _):
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
    
    func fetchMeals(from endpoint: Endpoint) -> AnyPublisher<[Meal], Never> {
        guard let url = endpoint.absoluteURL else {
            return Just([Meal]()).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .map { $0.response!}
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
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
//                    print(response.response)
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
    
    func fetchRecWithoutToekenMeals(completion: @escaping ((Result<[Meal], Error>) -> Void)) {

        guard let url = URL(string: Consts.URLStringRecWithoutTokenMeal) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(MealResponse.self, from: data)
//                    print(response.response)
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
