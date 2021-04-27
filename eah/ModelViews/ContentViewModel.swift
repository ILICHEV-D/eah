import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
        
    

    init() {
        
        let allItemsInit = Bundle.main.decode([Meal].self, from: "menu.json") //!!!
        self.allItems = allItemsInit
        
        self.recomendationItems = allItemsInit.filter {$0.recommendation == true}
        self.popular = allItemsInit.filter {$0.popular == true}
        self.mealPlanner = allItemsInit.filter {$0.mealPlanner == true}


        
        self.week = [
            Week(name: "Monday"), Week(name: "Tuesday"), Week(name: "Wednesday"), Week(name: "Thursday"), Week(name: "Friday"), Week(name: "Saturday"), Week(name: "Sunday")
        ]
        
        self.selectedDay = week.first!
        
        self.allIngredients = ["cucumber", "chickenThigh", "tomato", "chili", "egg", "avocado", "orange", "cheese", "bread", "watermelon", "corn", "potatoes"]
        
        self.suggestedIngredients = allIngredients
        
        self.breakfast = self.allItems

        
    }
    
    @Published var allItems: [Meal] = []
    
    @Published var recomendationItems: [Meal] = []
    
    @Published var breakfast: [Meal] = []
    @Published var lunch: [Meal] = []
    @Published var dinner: [Meal] = []
    
    
    
    @Published var allIngredients: [String] = []
    
    @Published var suggestedIngredients: [String] = []
    @Published var selectedIngredients: [String] = []
    
//
//    @Published var recomendationItems = [
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ]),
//
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ]),
//
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili"]),
//
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ])
//    ]
    
    @Published var popular: [Meal] = [
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ]),
//
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ]),
//
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili"]),
//
//        Meal(name: "Mie Ayam", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.breakfast, star: 4.5, image: "pop1", calories: 120, protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ])
    ]

    @Published var mealPlanner: [Meal] = [
//        Meal(name: "Egg with Avocado", time: "20-30 min", type: "Indo-Food", timeFoodIntake: FoodIntake.breakfast, image: "mealPlanner1", protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ]),
//
//        Meal(name: "Tuna poke", time: "20-30 min", type: "Korean-Food", timeFoodIntake: FoodIntake.lunch, image: "mealPlanner2", protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ]),
//
//        Meal(name: "Egg with Avocado", time: "20-30 min", type: "Indo-Food", timeFoodIntake: FoodIntake.breakfast, image: "mealPlanner3", protein: 120, fat: 120, carbs: 110, description: "Chicken noodles is a food made from noodles and a mixture of traditional Indonesian spices", ingridients: ["chickenThigh", "cucumber", "tomato", "egg", "chili" ])
    ]

    @Published var week: [Week]
    
    @Published var selectedDay: Week = Week(name: "Monday") //!!!
    
}
