
import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var userName = "" {
        didSet {print("printUserName --> \(userName)")}
    }
    
    @Published var searchName: String = "" {
        didSet {
            searchItems = []
//            searchItemsLimit = 0
            print("searchName --> \(self.searchName)")
            if self.searchName.count >= 2 {
                obtainSearchMeals()
            }
        }
    }
    @Published var searchIngredients: String = ""
    
    @Published var searchStringMealsWithIngr: String = "" {
        didSet {print("searchStringMealsWithIngr --> \(searchStringMealsWithIngr.count)")}
    }
    
    @Published var allItems: [Meal] = [] {
        didSet {print("allItems --> \(self.allItems.count)")}
    }
    
    @Published var mealPlannerItems: [Meal] = [] {
        didSet {
            print("mealPlannerItems --> \(self.mealPlannerItems.count)")
            mealPlannerItemsDidSet()
        }
    }
    
    @Published var recomendationLimit: Int = 0 {
        didSet {print("recomendationLimit --> \(self.recomendationLimit)")}
    }
    
    @Published var popularLimit: Int = 0 {
        didSet {
            print("popularLimit --> \(self.popularLimit)")
            obtainPopularMeals()
        }
    }
    
    @Published var allItemsLimit: Int = 0 {
        didSet {
            print("allItemsLimit --> \(self.allItemsLimit)")
            getAllMeals()
        }
    }
    
    @Published var mealWithIngredientsLimit: Int = 0 {
        didSet {
            print("mealWithIngredientsLimit --> \(self.mealWithIngredientsLimit)")
            getMealsWithIngredients()
        }
    }
    
    
    @Published var recomendationItems: [Meal] = [] {
        didSet {print("recomendationItems --> \(self.recomendationItems.count)")}
    }
    
    @Published var popular: [Meal] = [] {
        didSet {print("popular --> \(self.popular.count)")}
    }
    
    @Published var searchItems: [Meal] = [] {
        didSet {print("searchItems --> \(self.searchItems.count)")}
    }
    
    @Published var searchIngredientsItems: [Ingredient] = [] {
        didSet {print("searchIngredientsItems --> \(self.searchIngredientsItems.count)")}
    }
    
    @Published var allIngredients: [Ingredient] = [] {
        didSet {print("allIngredients --> \(self.allIngredients.count)")
            self.suggestedIngredients = allIngredients
            self.suggestedForBuyIngredients = allIngredients
        }
    }
    
    @Published var mealWithIngredients: [Meal] = [] {
        didSet {print("mealWithIngredients --> \(self.mealWithIngredients.count)")}
    }
    
    @Published var endpoint3: Endpoint = Endpoint(index: 5, limit: 1)!
    
    private var cancellableSet4: Set<AnyCancellable> = []
    private var cancellableSet5: Set<AnyCancellable> = []
    
    @Published var favoriteMeals: [Meal] = []
    
    @Published var suggestedIngredients: [Ingredient] = []
    @Published var selectedIngredients: [Ingredient] = []
    
    @Published var suggestedForBuyIngredients: [Ingredient] = []
    @Published var selectedForBuyIngredients: [Ingredient] = []
    
    @Published var shoppingList: [Ingredient: Int] = [:] {
        didSet {print("shoppingList --> \(self.shoppingList.count)")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(shoppingList), forKey:"shoppingList")
        }
    }

    @Published var selectedDay: Week = .todayWeekDay
    
    init() {
        
        self.suggestedIngredients = allIngredients
        self.suggestedForBuyIngredients = allIngredients
        
        // MARK: - NetworkInit
        
        $endpoint3
            .flatMap { (endpoint3) -> AnyPublisher<[Ingredient], Never> in
                MealAPI.shared.fetchIngredients(from: endpoint3)}
            .assign(to: \.allIngredients, on: self)
            .store(in: &self.cancellableSet5)
        
        $searchIngredients
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (searchIngredients) -> AnyPublisher<[Ingredient], Never> in
                Future<[Ingredient], Never> { (promise) in
                    if 2...30 ~= searchIngredients.count {
                        MealAPI.shared.fetchIngredients(from:.searchIngredients(limit: 1, searchString: searchIngredients))
                            .sink(receiveValue: {value in promise(.success(value))})
                            .store(in: &self.cancellableSet4)
                    }
                    else {promise(.success([Ingredient]()))
                        
                    }
                }.eraseToAnyPublisher()
            }.assign(to: \.searchIngredientsItems, on: self)
            .store(in: &self.cancellableSet4)
        
        // MARK: - MealPlanner init
        
        mealPlannerInit()
    }
    
    private func obtainInitialItems() {
        obtainSearchMeals()
        obtainPopularMeals()
        getLikes()
        obtainRecomendationMeals()
        loadName()
        AuthApi.loadUserImage()
        loadFavorite()
    }
    
    private func loadName() {
        if let nameFromUD = UserDefaults.standard.value(forKey:"name") as? String {
            self.userName = nameFromUD
        }
        else {
            print("Пользователь не авторизован")
        }
    }
}
