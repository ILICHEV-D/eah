
import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var userName = "" {
        didSet {print("printUserName --> \(userName)")}
    }
    
    @Published var searchName: String = ""
    @Published var searchIngredients: String = ""
    @Published var searchStringMealsWithIngr: String = "" {
        didSet {print("searchStringMealsWithIngr --> \(searchStringMealsWithIngr.count)")}
    }
    
    @Published var allItems: [Meal] = [] {
        didSet {print("allItems --> \(self.allItems.count)")}
    }
    
    @Published var mealPlannerItems: [Meal] = [] {
        didSet {print("mealPlannerItems --> \(self.mealPlannerItems.count)")
            var days: [Date] = []
            var time: [String] = []
            mealPlannerItems.forEach({
                if let dayOfWeek = $0.dayOfWeek {
                    days.append(dayOfWeek.date)
                    time.append(dayOfWeek.time)
                }})
            
            UserDefaults.standard.setValue(days, forKey:"days")
            UserDefaults.standard.setValue(time, forKey:"time")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(mealPlannerItems), forKey:"mealPlanner")
        }
    }
    
    
    
    @Published var recomendationLimit: Int = 0 {
        didSet {print("recomendationLimit --> \(self.recomendationLimit)")}
    }
    
    @Published var popularLimit: Int = 0 {
        didSet {print("popularLimit --> \(self.popularLimit)")}
    }
    
    @Published var allItemsLimit: Int = 0 {
        didSet {print("allItemsLimit --> \(self.allItemsLimit)")}
    }
    
    @Published var mealWithIngredientsLimit: Int = 0 {
        didSet {print("mealWithIngredientsLimit --> \(self.mealWithIngredientsLimit)")}
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
    
    @Published var endpoint0: Endpoint = Endpoint(index: 0, limit: 0)!
//    @Published var endpoint1: Endpoint = Endpoint(index: 1, limit: 0)!
    @Published var endpoint2: Endpoint = Endpoint(index: 2, limit: 0)!
    @Published var endpoint3: Endpoint = Endpoint(index: 5, limit: 1)!
    @Published var endpoint6: Endpoint = Endpoint(index: 6, limit: 0)!
    
    private var cancellableSet0: Set<AnyCancellable> = []
    private var cancellableSet1: Set<AnyCancellable> = []
    private var cancellableSet2: Set<AnyCancellable> = []
    private var cancellableSet3: Set<AnyCancellable> = []
    private var cancellableSet4: Set<AnyCancellable> = []
    private var cancellableSet5: Set<AnyCancellable> = []
    private var cancellableSet6: Set<AnyCancellable> = []
    
    var breakfast: [Meal] {return self.mealPlannerFunc(day: selectedDay).0}
    var lunch: [Meal] {return self.mealPlannerFunc(day: selectedDay).1}
    var dinner: [Meal] {return self.mealPlannerFunc(day: selectedDay).2}
    
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
    
    @Published var week: [Week]
    @Published var selectedDay: Week = Week(name: "Monday", russianName: "Понедельник")
    
    
    init() {
        // MARK: - WeekInit
        
        self.week = [
            Week(name: "Monday", russianName: "Пн"), Week(name: "Tuesday", russianName: "Вт"), Week(name: "Wednesday", russianName: "Ср"), Week(name: "Thursday", russianName: "Чт"), Week(name: "Friday", russianName: "Пт"), Week(name: "Saturday", russianName: "Сб"), Week(name: "Sunday", russianName: "Вс")
        ]
        
        self.selectedDay = self.week[self.week.firstIndex(where: {
            $0.name == DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: Date())-1]
        }) ?? 0]
        self.suggestedIngredients = allIngredients
        self.suggestedForBuyIngredients = allIngredients
        
        // MARK: - NetworkInit
        
        $endpoint0
            .flatMap { (endpoint0) -> AnyPublisher<[Meal], Never> in
                MealAPI.shared.fetchMeals(from: endpoint0)}
            .sink(receiveValue: { meals in
                self.allItems.append(contentsOf: meals)})
            .store(in: &self.cancellableSet0)
        
//        $endpoint1
//            .flatMap { (endpoint1) -> AnyPublisher<[Meal], Never> in
//                return MealAPI.shared.fetchMeals(from: endpoint1)}
//            .sink(receiveValue: { meals in
//                self.recomendationItems.append(contentsOf: meals)})
//            .store(in: &self.cancellableSet1)
        
        $endpoint2
            .flatMap { (endpoint2) -> AnyPublisher<[Meal], Never> in
                MealAPI.shared.fetchMeals(from: endpoint2)}
            .sink(receiveValue: { meals in
                self.popular.append(contentsOf: meals)})
            .store(in: &self.cancellableSet2)
        
        $endpoint3
            .flatMap { (endpoint3) -> AnyPublisher<[Ingredient], Never> in
                MealAPI.shared.fetchIngredients(from: endpoint3)}
            .assign(to: \.allIngredients, on: self)
            .store(in: &self.cancellableSet5)
        
        $endpoint6
            .flatMap { (endpoint6) -> AnyPublisher<[Meal], Never> in
                MealAPI.shared.fetchMeals(from: .mealWithIngredients(limit: 0, searchString: self.searchStringMealsWithIngr))}
            .sink(receiveValue: { meals in
                self.mealWithIngredients.append(contentsOf: meals)})
            .store(in: &self.cancellableSet6)
        
        $searchName
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (searchName) -> AnyPublisher<[Meal], Never> in
                Future<[Meal], Never> { (promise) in
                    if 2...30 ~= searchName.count {
                        MealAPI.shared.fetchMeals(from:.search(limit: 1, searchString: searchName))
                            .sink(receiveValue: {value in promise(.success(value))})
                            .store(in: &self.cancellableSet3)
                    }
                    else {promise(.success([Meal]()))
                        
                    }
                }.eraseToAnyPublisher()
            }.assign(to: \.searchItems, on: self)
            .store(in: &self.cancellableSet3)
        
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
        
        getLikes()
        getRecMeals()
        loadName()
        AuthApi.loadUserImage()
        loadFavorite()
        
        // MARK: - MealPlanner init
        
        var days: [Date] = []
        var time: [String] = []
        
        if let day = UserDefaults.standard.value(forKey:"days") as? [Date] {
            days = day
        }
        
        if let t = UserDefaults.standard.value(forKey:"time") as? [String] {
            time = t
        }
        
        if let meals = UserDefaults.standard.value(forKey:"mealPlanner") as? Data {
            mealPlannerItems = try! PropertyListDecoder().decode(Array<Meal>.self, from: meals)
            for i in 0..<mealPlannerItems.count {
                mealPlannerItems[i].dayOfWeek = DayOfWeek(date: days[i], time: time[i])
            }
        }
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
