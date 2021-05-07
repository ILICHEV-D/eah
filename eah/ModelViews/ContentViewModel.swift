import Foundation
import SwiftUI
//import Combine

class ContentViewModel: ObservableObject {
        
    init() {
        
        self.allItems = Bundle.main.decode([Meal].self, from: "menu.json") //!!!
        
        self.week = [
            Week(name: "Monday"), Week(name: "Tuesday"), Week(name: "Wednesday"), Week(name: "Thursday"), Week(name: "Friday"), Week(name: "Saturday"), Week(name: "Sunday")
        ]
        
        self.allIngredients = ["cucumber", "chickenThigh", "tomato", "chili", "egg", "avocado", "orange", "cheese", "bread", "watermelon", "corn", "potatoes"]

        self.selectedDay = self.week[self.week.firstIndex(where: {
            $0.name == DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: Date())]
        }) ?? 0]
        
        print(DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: Date())])
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
                    if i.week.name == day.name {
                        if i.foodIntake == "breakfast" {
                            breakfast.append(item)
                        }
                        else if i.foodIntake == "lunch" {
                            lunch.append(item)
                        }
                        else if i.foodIntake == "dinner" {
                            dinner.append(item)
                        }
                    }
                
            }
        }
        return (breakfast, lunch, dinner)
    }

    var breakfast: [Meal] {return mealPlannerFunc(day: selectedDay).0}
    var lunch: [Meal] {return mealPlannerFunc(day: selectedDay).1}
    var dinner: [Meal] {return mealPlannerFunc(day: selectedDay).2}
    
    var favoriteMeals: [Meal] {return allItems.filter {$0.favorites == true}}
    
    @Published var allIngredients: [String] = []
    @Published var suggestedIngredients: [String] = []
    @Published var selectedIngredients: [String] = []
    
    @Published var suggestedForBuyIngredients: [String] = []
    @Published var selectedForBuyIngredients: [String] = []
    
    @Published var shoppingList: [String: Int] = [:]

    @Published var week: [Week]
    @Published var selectedDay: Week = Week(name: "Monday")
}
