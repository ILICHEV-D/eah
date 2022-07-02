//
//  ContentViewModel+Week.swift
//  eah
//
//  Created by Danil Ilichev on 27.03.2022.
//

import Foundation
import SwiftUI

extension ContentViewModel {
    
    var breakfast: [Meal] {return self.mealPlannerFunc(day: selectedDay).0}
    var lunch: [Meal] {return self.mealPlannerFunc(day: selectedDay).1}
    var dinner: [Meal] {return self.mealPlannerFunc(day: selectedDay).2}
    
    func mealPlannerInit() {
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
    
    func mealPlannerItemsDidSet() {
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
    
    func mealPlannerFunc(day: Week) -> ([Meal], [Meal], [Meal]) {
        var breakfast: [Meal] = []
        var lunch: [Meal] = []
        var dinner: [Meal] = []
        
        for item in self.mealPlannerItems {
            if let i = item.dayOfWeek {
                if i.date.getTodayWeekDay() == day.name {
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
    
}
