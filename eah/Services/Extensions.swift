import Foundation
import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//
//func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
//    Binding(
//        get: { lhs.wrappedValue ?? rhs },
//        set: { lhs.wrappedValue = $0 }
//    )
//}

extension Date {

    func getWeekDate(week: String) -> (Date) {
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        
        switch week {
            case "Monday":
                return arrThisWeek[0]
            case "Tuesday":
                return arrThisWeek[1]
            case "Wednesday":
                return arrThisWeek[2]
            case "Thursday":
                return arrThisWeek[3]
            case "Friday":
                return arrThisWeek[4]
            case "Saturday":
                return arrThisWeek[5]
            case "Sunday":
                return arrThisWeek[6]
            default:
                return arrThisWeek[0]
        }
    }

    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
}
