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
    
    var recommendation: Bool
    var popular: Bool
    var mealPlanner: Bool
    
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
    case avocado = "avocado"
    case orange = "orange"
    case cheese = "cheese"
    case bread = "bread"
    case watermelon = "watermelon"
    case corn = "corn"
    case potatoes = "potatoes"
}

struct Ingridient {
    var name: String
    var imageSmile: String
    var color: Color?
}

func convertIngridient(item: helpEnumIngredients) -> Ingridient {
    switch item {
    case .chickenThigh:
        return(Ingridient(name: "Chicken thigh", imageSmile: "🍗", color: Color("breadColor")))
    case .cucumber:
        return(Ingridient(name: "Cucumber", imageSmile: "🥒", color: Color("cucumberColor")))
    case .tomato:
        return(Ingridient(name: "Tomato", imageSmile: "🍅", color: Color("tomatoColor")))
    case .chili:
        return(Ingridient(name: "Chili", imageSmile: "🌶", color: Color("chiliColor")))
    case .egg:
        return(Ingridient(name: "Egg", imageSmile: "🥚", color: Color("eggColor")))
    case .potatoes:
        return(Ingridient(name: "Potatoes", imageSmile: "🍠", color: Color("potatoesColor")))
    case .avocado:
        return(Ingridient(name: "Avocado", imageSmile: "🥑", color: Color("avocadoColor")))
    case .orange:
        return(Ingridient(name: "Orange", imageSmile: "🍊", color: Color("orangeColor")))
    case .cheese:
        return(Ingridient(name: "Cheese", imageSmile: "🧀", color: Color("cheeseColor")))
    case .bread:
        return(Ingridient(name: "Bread", imageSmile: "🍞", color: Color("breadColor")))
    case .watermelon:
        return(Ingridient(name: "Watermelon", imageSmile: "🍉", color: Color("watermelonColor")))
    case .corn:
        return(Ingridient(name: "Corn", imageSmile: "🌽", color: Color("cornColor")))
    }
    
    
}



