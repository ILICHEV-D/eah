import SwiftUI



//struct Meal1: Codable, Equatable {
//    var id: Int
//    var name: String
//    var kind: String
//    var time: Int
//
//}

//struct MealJSON: Codable, Equatable {
//    var status: Bool
//    var response: [Meal1]
//}

struct MealResponse: Codable {
    let results: [Meal]
}

struct Meal: Identifiable, Codable, Equatable {

    static func ==(lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    var name: String
    var time: String
    var type: String?
    var timeFoodIntake: String?
    var star: Double?
    var image: String = "backColor"
    var calories: Int?
    var protein: Int?
    var fat: Int?
    var carbs: Int?
    var description: String?
    var ingridients: [String]?
    
    var dayOfWeek: [DayOfWeek] = []
    
    var recommendation: Bool?
    var popular: Bool?
    var favorites: Bool?
    
    var mealPlanner: Bool?
}

struct DayOfWeek: Codable {
    let date: Date
    let time: String
}

//struct DayOfWeek: Codable {
//    var week: Week
//    var foodIntake: String
//}

struct Week: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var russianName: String
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
        return(Ingridient(name: "Куриное бедро", imageSmile: "🍗", color: Color("breadColor")))
    case .cucumber:
        return(Ingridient(name: "Огурец", imageSmile: "🥒", color: Color("cucumberColor")))
    case .tomato:
        return(Ingridient(name: "Помидор", imageSmile: "🍅", color: Color("tomatoColor")))
    case .chili:
        return(Ingridient(name: "Перец Чили", imageSmile: "🌶", color: Color("chiliColor")))
    case .egg:
        return(Ingridient(name: "Яйцо", imageSmile: "🥚", color: Color("eggColor")))
    case .potatoes:
        return(Ingridient(name: "Картофель", imageSmile: "🍠", color: Color("potatoesColor")))
    case .avocado:
        return(Ingridient(name: "Авокадо", imageSmile: "🥑", color: Color("avocadoColor")))
    case .orange:
        return(Ingridient(name: "Апельсин", imageSmile: "🍊", color: Color("orangeColor")))
    case .cheese:
        return(Ingridient(name: "Сыр", imageSmile: "🧀", color: Color("cheeseColor")))
    case .bread:
        return(Ingridient(name: "Хлеб", imageSmile: "🍞", color: Color("breadColor")))
    case .watermelon:
        return(Ingridient(name: "Арбуз", imageSmile: "🍉", color: Color("watermelonColor")))
    case .corn:
        return(Ingridient(name: "Кукуруза", imageSmile: "🌽", color: Color("cornColor")))
    }
    
    
}



