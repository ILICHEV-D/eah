import SwiftUI


struct Meal: Identifiable, Codable, Equatable {
    var id = UUID().uuidString
    var name: String
    var time: String
    var type: String
    var timeFoodIntake: String?
    var star: Double?
    var image: String
    var calories: Int?
    var protein: Int?
    var fat: Int?
    var carbs: Int?
    var description: String?
    var ingridients: [String]?
    
}

struct Week: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
}


enum FoodIntake {
    static let breakfast = "Breakfast"
    static let lunch = "Lunch"
    static let dinner = "Dinner"
}


enum helpEnumIngredients: String {
    case chickenThigh = "chickenThigh"
    case cucumber = "cucumber"
    case tomato = "tomato"
    case chili = "chili"
    case egg = "egg"
}

struct Ingridient {
    var name: String
    var imageSmile: String
}


func convertIngridient(item: helpEnumIngredients) -> Ingridient {
    switch item {
    case .chickenThigh:
        return(Ingridient(name: "Chicken thigh", imageSmile: "🍗"))
    case .cucumber:
        return(Ingridient(name: "Cucumber", imageSmile: "🥒"))
    case .tomato:
        return(Ingridient(name: "Tomato", imageSmile: "🍅"))
    case .chili:
        return(Ingridient(name: "Chili", imageSmile: "🌶"))
    case .egg:
        return(Ingridient(name: "Egg", imageSmile: "🥚"))
    }
}



