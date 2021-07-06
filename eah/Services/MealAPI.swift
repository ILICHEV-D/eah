import Foundation
import Combine
import UIKit

enum Endpoint {
    
       case popular
        case nothing
       case search (searchString: String)
    
       var baseURL:URL {URL(string: "https://mocki.io/v1/81760f0b-2dee-47ed-8fd1-047eb907eafe")!}
       
       func path() -> String {
           switch self {
           case .nothing:
                return ""
           case .popular:
               return ".../popular" //!!!
           case .search(_):
               return "/search/movie"
           }
       }
    
    init? (index: Int) {
           switch index {
           case 0: self = .nothing
           case 1: self = .popular
           default: return nil
           }
       }
    
    var absoluteURL: URL? {
//        let queryURL = baseURL.appendingPathComponent(self.path())
//        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
//        guard var urlComponents = components else {
//            return nil
//        }
//        switch self {
//        case .search (let name):
//            urlComponents.queryItems = [URLQueryItem(name: "startswith", value: name),
//
//                                    //    URLQueryItem(name: "page", value: "1")
//                                    ]
//        default:
//             urlComponents.queryItems = [
//                                //        URLQueryItem(name: "page", value: "1")
//                                     ]
//        }
 //       return urlComponents.url
        return baseURL
    }
    
}
    
    class MealAPI {
        
        public static let shared = MealAPI()
        
        private var subscriptions = Set<AnyCancellable>()
        deinit {
               for cancell in subscriptions {
                   cancell.cancel()
               }
           }
        
        
        struct APIConstants {
          //  static let apiKey: String = "1d9b898a212ea52e283351e521e17871"
            
            static let jsonDecoder: JSONDecoder = {
                   let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                   let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "yyyy-mm-dd"
                       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    return jsonDecoder
                  }()
        }
        
        
//        func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
//                      URLSession.shared.dataTaskPublisher(for: url)             // 1
//                       .map { $0.data}                                          // 2
//                       .decode(type: T.self, decoder: JSONDecoder()) // 3
//                       .receive(on: RunLoop.main)                               // 4
//                       .eraseToAnyPublisher()                                   // 5
//           }
        
        var cancellable: AnyCancellable?

//        private var meals: [Meal] = [] {
//            didSet {
//                print("posts --> \(self.meals)")
//            }
//        }
        
        func fetchMeals(from endpoint: Endpoint)
                                        -> AnyPublisher<[Meal], Never> {
            guard let url = endpoint.absoluteURL else {
                        return Just([Meal]()).eraseToAnyPublisher() // 0
            }
            

            return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Meal].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
      //      .assign(to: \.meals, on: self)
            
            
//            return fetch(url)                                        // 1
//                .map { (response: MealResponse) -> [Meal] in      // 2
//                                response.results }
//                   .replaceError(with: [Meal]())                    // 3
//                   .eraseToAnyPublisher()
        }
        
    }

