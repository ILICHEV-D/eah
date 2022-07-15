//
//  ContentViewModel+API.swift
//  eah
//
//  Created by Danil Ilichev on 27.03.2022.
//

import Foundation
import SwiftUI

extension ContentViewModel {
    
    func getAllMeals() {
        MealAPI.shared.fetchAllMeals(offset: allItemsLimit) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.allMeals.append(contentsOf: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMealsWithIngredients() {
        MealAPI.shared.fetchMealWithIngredients(offset: mealWithIngredientsLimit, searchString: searchStringMealsWithIngr) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.mealWithIngredients = response
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainSearchMeals() {
        MealAPI.shared.fetchMealWithSearch(offset: 0, searchString: searchName) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.searchItems = response
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainPopularMeals() {
        MealAPI.shared.fetchPopularMeals(offset: popularLimit) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.popular.append(contentsOf: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainCategories() {
        MealAPI.shared.fetchFirstCategoriesMeals { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.firstCategory.append(contentsOf: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        MealAPI.shared.fetchSecondCategoriesMeals{ result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.secondCategory.append(contentsOf: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        MealAPI.shared.fetchThirdsCategoriesMeals { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.thirdCategory.append(contentsOf: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func obtainAllAllIngredients() {
        IngredientAPI.shared.fetchAllIngredients { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.allIngredients.append(contentsOf: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func obtainSearchIngredients() {
        IngredientAPI.shared.fetchMealWithSearch(searchString: searchIngredients) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.searchIngredientsItems = response
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //TODO: refactoring

    func getLikes() {
        if AuthService.token != nil {
            AuthApi.getLikes(completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.favoriteMeals = response
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    
    
//    func loadFavorite() {
//        if AuthService.token != nil {
//            AuthApi.getLikes(completion: { result in
//                switch result {
//                case .success(let response):
//                    if response.status == false {
//                        print(response)
//                    } else {
//                        for i in response.response {
//                            AuthApi.getMealFromUid(uid: i.recipeUid!) { result in
//                                switch result {
//                                case .success(let meal):
//                                    if !self.favoriteMeals.contains(meal) {
//                                        DispatchQueue.main.async {
//                                            self.favoriteMeals.append(meal)
//                                        }
//                                    }
//                                case .failure(let error):
//                                    print(error.localizedDescription)
//                                }
//                            }
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            })
//        }
//
//        if let shopList  = UserDefaults.standard.value(forKey: "shoppingList") as? Data {
//            DispatchQueue.main.async {
//                self.shoppingList = try! PropertyListDecoder().decode([Ingredient: Int].self, from: shopList)
//                self.selectedForBuyIngredients = self.shoppingList.map({ $0.key})
//            }
//
//        }
//    }
    
    func obtainRecomendationMeals() {
        if (AuthService.token != nil) {
            MealAPI.shared.fetchRecMeals { result in
                switch result {
                case .success(let response):
                    print(response.response.count)
                    for i in response.response {
                        AuthApi.getMealFromUid(uid: i) { result in
                            
                            switch result {
                            case .success(let meal):
                                if !self.favoriteMeals.contains(meal) {
                                    DispatchQueue.main.async {
                                        self.recomendationItems.append(meal)
                                    }
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            MealAPI.shared.fetchRecWithoutToekenMeals { result in
                switch result {
                case .success(let response):
                    print(response)
                    self.recomendationItems = response
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
