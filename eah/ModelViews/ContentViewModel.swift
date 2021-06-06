import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
        
    init() {
        
    //    self.allItems = Bundle.main.decode([Meal].self, from: "menu.json") //!!!


        if let data = UserDefaults.standard.value(forKey:"allItems") as? Data {
            self.allItems = try! PropertyListDecoder().decode(Array<Meal>.self, from: data)
            print("from storage")
        } else {
            self.allItems = Bundle.main.decode([Meal].self, from: "menu.json") //!!!
            print("from json")
        }

        
        self.week = [
            Week(name: "Monday"), Week(name: "Tuesday"), Week(name: "Wednesday"), Week(name: "Thursday"), Week(name: "Friday"), Week(name: "Saturday"), Week(name: "Sunday")
        ]
        
        self.allIngredients = ["cucumber", "chickenThigh", "tomato", "chili", "egg", "avocado", "orange", "cheese", "bread", "watermelon", "corn", "potatoes"]

        self.selectedDay = self.week[self.week.firstIndex(where: {
            $0.name == DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: Date())-1]
        }) ?? 0]
        
        self.suggestedIngredients = allIngredients
        self.suggestedForBuyIngredients = allIngredients
    }
    
    @Published var allItems: [Meal] = []
    
    var recomendationItems: [Meal] {return allItems.filter {$0.recommendation == true}}
    var popular: [Meal] {return allItems.filter {$0.popular == true}}
    var mealPlanner: [Meal] {return allItems.filter {$0.mealPlanner == true}}
    
    
    func mealPlannerFunc(day: Week) -> ([Meal], [Meal], [Meal]) {
        var breakfast: [Meal] = []
        var lunch: [Meal] = []
        var dinner: [Meal] = []

        for item in self.allItems {
                for i in item.dayOfWeek {
                    if getTodayWeekDay(date: i.date) == day.name {
                        if i.time == "breakfast" {
                            breakfast.append(item)
                        }
                        else if i.time == "lunch" {
                            lunch.append(item)
                        }
                        else if i.time == "dinner" {
                            dinner.append(item)
                        }
                    }
                    
                
            }
        }
        return (breakfast, lunch, dinner)
    }
    
    func jsonDateToSwiftDate(jsonDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: jsonDate) {
            return date
        }
        else {return nil}
        
    }
    
    func getTodayWeekDay(date: Date)-> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           let weekDay = dateFormatter.string(from: date)
           return weekDay
     }
    
    
    

    var breakfast: [Meal] {return self.mealPlannerFunc(day: selectedDay).0}
    var lunch: [Meal] {return self.mealPlannerFunc(day: selectedDay).1}
    var dinner: [Meal] {return self.mealPlannerFunc(day: selectedDay).2}
    
    var favoriteMeals: [Meal] {return allItems.filter {$0.favorites == true}}
    
    @Published var allIngredients: [String] = []
    @Published var suggestedIngredients: [String] = []
    @Published var selectedIngredients: [String] = []
    
    @Published var suggestedForBuyIngredients: [String] = []
    @Published var selectedForBuyIngredients: [String] = []
    
    @Published var shoppingList: [String: Int] = [:]

    @Published var week: [Week]
    @Published var selectedDay: Week = Week(name: "Monday")
    
    
    func saveData() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(allItems), forKey:"allItems")
    }
    
}
