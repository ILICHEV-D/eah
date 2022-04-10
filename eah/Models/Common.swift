import SwiftUI

// MARK: - Meal

struct MealResponse: Codable {
    let status : Bool?
    let response : [Meal]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case response = "response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        response = try values.decodeIfPresent([Meal].self, forKey: .response)
    }
}

struct Meal: Identifiable, Codable, Equatable {
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.uid == rhs.uid
    }
    let uid, name: String
    let time: Int?
    var stringTime: String? { get {
        if ((time ?? 0) / 3600 ) >= 1 {
            if (time ?? 0) % 3600 == 0 {
                return String("\(((time ?? 0) / 3600 )) ч")
            }
            else {
                return String("\(((time ?? 0) / 3600 )) ч \(((time ?? 0) % 3600) / 60) мин")
            }
        } else {
            return String("\((time ?? 0) / 60) мин")
        }
    }
    }
    let ePower: EPower?
    var ingredients: [Ingredient]?
    let likesCount: Int?
    let cookingStages: [CookingStage]?
    let previewImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "Uid"
        case name = "Name"
        case time = "Time"
        case ePower = "EPower"
        case ingredients = "Ingredients"
        case likesCount = "LikesCount"
        case cookingStages = "CookingStages"
        case previewImageURL = "PreviewImageUrl"
    }
    
    var id: String? = UUID().uuidString
    var type: String?
    var star: Double?
    var description: String?
    var dayOfWeek: DayOfWeek?
    var recommendation: Bool?
    var popular: Bool?
    var favorites: Bool?
}

struct CookingStage: Codable, Hashable {
    let text: String?
    let imageLink: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case imageLink = "ImageLink"
    }
}

struct EPower: Codable {
    let uid: String?
    let calories, fats, proteins, carbonhydrates: Double?
    
    enum CodingKeys: String, CodingKey {
        case uid = "Uid"
        case calories = "Calories"
        case fats = "Fats"
        case proteins = "Proteins"
        case carbonhydrates = "Carbonhydrates"
    }
}

// MARK: - Ingredient

struct IngredientResponse: Codable {
    let status: Bool?
    let response: [Ingredient]?
}

struct Ingredient: Codable, Hashable, Identifiable {
    static func > (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name > rhs.name
    }
    var id: String? = UUID().uuidString
    let uid: String?
    let name: String
    var amount: Double?
    let unit: String?
    var imageSmile: String = "🥒"
    var color: Color?
    
    enum CodingKeys: String, CodingKey {
        case uid = "Uid"
        case name = "Name"
        case amount = "Amount"
        case unit = "Unit"
    }
}

// MARK: - Week

struct DayOfWeek: Codable {
    let date: Date
    let time: String
}

struct Week: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var russianName: String
}

enum FoodIntake {
    static let breakfast = "Завтрак"
    static let lunch = "Обед"
    static let dinner = "Ужин"
}

// MARK: - AuthModel

struct AuthModel: Codable {
    let status: Bool
    let response: AuthResponse
}

struct AuthResponse: Codable {
    let email: String
    let firstName: String?
    let age: Int?
    let sex: Bool?
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case firstName = "FirstName"
        case age = "Age"
        case sex = "Sex"
        case token = "Token"
    }
}

struct AuthSimpleResponse: Codable {
    let status: Bool
    let response: String?
    
}

struct LikesModel: Codable {
    let status: Bool?
    let response: [Response]
}

struct LikesRecModel: Codable {
    let status: Bool?
    let response: [String]
}

// MARK: - Response

struct Response: Codable {
    let uid, userUid, user, recipeUid: String?
    let recipe, createDate: String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "Uid"
        case userUid = "UserUid"
        case user = "User"
        case recipeUid = "RecipeUid"
        case recipe = "Recipe"
        case createDate = "CreateDate"
    }
}
