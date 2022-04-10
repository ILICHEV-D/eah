//
//  ContentViewModel+API.swift
//  eah
//
//  Created by Danil Ilichev on 27.03.2022.
//

import Foundation
import SwiftUI

extension ContentViewModel {
    
    func getLikes() {
        if AuthApi.token != nil {
            AuthApi.getLikes(completion: { result in
                switch result {
                case .success(let response):
                    if response.status == false {
                        print(response)
                    } else {
                        for i in response.response {
                            AuthApi.getMealFromUid(uid: i.recipeUid!) { result in
                                switch result {
                                case .success(let meal):
                                    if !self.favoriteMeals.contains(meal) {
                                        DispatchQueue.main.async {
                                            self.favoriteMeals.append(meal)
                                        }
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    func loadFavorite() {
        if AuthApi.token != nil {
            AuthApi.getLikes(completion: { result in
                switch result {
                case .success(let response):
                    if response.status == false {
                        print(response)
                    } else {
                        for i in response.response {
                            AuthApi.getMealFromUid(uid: i.recipeUid!) { result in
                                switch result {
                                case .success(let meal):
                                    if !self.favoriteMeals.contains(meal) {
                                        DispatchQueue.main.async {
                                            self.favoriteMeals.append(meal)
                                        }
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
        
        if let shopList  = UserDefaults.standard.value(forKey: "shoppingList") as? Data {
            DispatchQueue.main.async {
                self.shoppingList = try! PropertyListDecoder().decode([Ingredient: Int].self, from: shopList)
                self.selectedForBuyIngredients = self.shoppingList.map({ $0.key})
            }
            
        }
    }
    
    func getRecMeals() {
        if (AuthApi.token != nil) {
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
