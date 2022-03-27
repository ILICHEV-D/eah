//
//  ContentViewModel+Week.swift
//  eah
//
//  Created by Danil Ilichev on 27.03.2022.
//

import Foundation
import SwiftUI

extension ContentViewModel {
    func mealPlannerFunc(day: Week) -> ([Meal], [Meal], [Meal]) {
        var breakfast: [Meal] = []
        var lunch: [Meal] = []
        var dinner: [Meal] = []
        
        for item in self.mealPlannerItems {
            if let i = item.dayOfWeek {
                
                
                let translateWeekDay: [String: String] = ["понедельник": "Monday",
                                                          "вторник": "Tuesday",
                                                          "среда": "Wednesday",
                                                          "четверг": "Thursday",
                                                          "пятница": "Friday",
                                                          "суббота": "Saturday",
                                                          "воскресенье": "Sunday"]
                
                if translateWeekDay[getTodayWeekDay(date: i.date)] == day.name {
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
    
    func getTodayWeekDay(date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
    
}
