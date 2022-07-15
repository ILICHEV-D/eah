
import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    // MARK: - UserData

    @Published var userName = "" {
        didSet {print("printUserName --> \(userName)")}
    }
    
    // MARK: - MealsData

    @Published var allMeals: [Meal] = [] { didSet {print("allItems --> \(self.allMeals.count)")}}
    @Published var allItemsLimit: Int = 0 {
        didSet {
            print("allItemsLimit --> \(self.allItemsLimit)")
            getAllMeals()
        }
    }
    
    @Published var recomendationItems: [Meal] = [] { didSet {print("recomendationItems --> \(self.recomendationItems.count)")} }
    @Published var recomendationLimit: Int = 0 {
        didSet {print("recomendationLimit --> \(self.recomendationLimit)")}
    }
    
    @Published var popular: [Meal] = [] { didSet {print("popular --> \(self.popular.count)")} }
    @Published var popularLimit: Int = 0 {
        didSet {
            print("popularLimit --> \(self.popularLimit)")
            obtainPopularMeals()
        }
    }
    
    
    @Published var firstCategory: [Meal] = [] { didSet {print("firstCategory --> \(self.firstCategory.count)")} }
    @Published var secondCategory: [Meal] = [] { didSet {print("secondCategory --> \(self.secondCategory.count)")} }
    @Published var thirdCategory: [Meal] = [] { didSet {print("thirdCategory --> \(self.thirdCategory.count)")} }

    
    @Published var mealWithIngredients: [Meal] = [] { didSet {print("mealWithIngredients --> \(self.mealWithIngredients.count)")} }
    @Published var mealWithIngredientsLimit: Int = 0 {
        didSet {
            print("mealWithIngredientsLimit --> \(self.mealWithIngredientsLimit)")
            getMealsWithIngredients()
        }
    }
    
    @Published var searchItems: [Meal] = [] { didSet {print("searchItems --> \(self.searchItems.count)")} }
    @Published var searchName: String = "" {
        didSet {
            searchItems = []
            print("searchName --> \(self.searchName)")
            if self.searchName.count >= 3 {
                obtainSearchMeals()
            }
            
            if self.searchName.count == 0 {
                obtainSearchMeals()
            }
        }
    }
    
    @Published var favoriteMeals: [Meal] = []

    // MARK: - MealPlannerData

    @Published var mealPlannerItems: [Meal] = [] {
        didSet {
            print("mealPlannerItems --> \(self.mealPlannerItems.count)")
            mealPlannerItemsDidSet()
        }
    }
    
    @Published var selectedDay: Week = .todayWeekDay

    // MARK: - IngredientsData

    @Published var allIngredients: [Ingredient] = [] {
        didSet {print("allIngredients --> \(self.allIngredients.count)")
            self.suggestedIngredients = allIngredients
            self.suggestedForBuyIngredients = allIngredients
        }
    }

    @Published var searchIngredients: String = "" {
        didSet {
            print("searchIngredients --> \(self.searchIngredients)")
            if self.searchIngredients.count >= 2 {
                obtainSearchIngredients()
            }
        }
    }
    @Published var searchStringMealsWithIngr: String = "" {
        didSet {print("searchStringMealsWithIngr --> \(searchStringMealsWithIngr.count)")}
    }
    
    @Published var searchIngredientsItems: [Ingredient] = [] {
        didSet {print("searchIngredientsItems --> \(self.searchIngredientsItems.count)")}
    }
    
    @Published var suggestedIngredients: [Ingredient] = []
    @Published var selectedIngredients: [Ingredient] = []
    
    @Published var suggestedForBuyIngredients: [Ingredient] = []
    @Published var selectedForBuyIngredients: [Ingredient] = []
    
    @Published var shoppingList: [Ingredient: Int] = [:] {
        didSet {print("shoppingList --> \(self.shoppingList.count)")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(shoppingList), forKey:"shoppingList")
        }
    }
    
    init() {
        self.suggestedIngredients = allIngredients
        self.suggestedForBuyIngredients = allIngredients
        
        mealPlannerInit()
        obtainInitialItems()
    }
    
    private func obtainInitialItems() {
        getAllMeals()
        obtainSearchMeals()
        obtainPopularMeals()
        obtainCategories()
        obtainAllAllIngredients()
        getLikes()
        obtainRecomendationMeals()
        AuthService.loadUserImage()
        AuthService.loadToken()
        AuthService.loadName()
    }
}
