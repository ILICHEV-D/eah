//
//  main.swift
//  yandex
//
//  Created by Danil Ilichev on 03.01.2022.
//

import Foundation
var W = 4
var H = 3

let readString = readLine()
let someArr = readString!.components(separatedBy: " ")
W = Int(someArr[0])!
H = Int(someArr[1])!


var arr: [[Int]] = []
arr.removeAll()
for i in 0..<H {
    var someArr: [Int] = []
    for _ in 0..<W {
        someArr.append(0)
    }
    arr.append(someArr)
}

for i in 0..<H {
    for j in 0..<W {
        let x1 = i + 1;
        let y1 = j + 1;
        let x2 = H - i;
        let y2 = W - j;

        arr[i][j] = x1 * y1 * x2 * y2;
    }
}

var arr1 = [Int]()
var arr2 = [Int]()



for i in arr {
    var sum1 = 0
    for j in i {
        sum1 += j
    }
    arr1.append(sum1)
}

for i in 0..<arr[0].count {
    var sum1 = 0
    for j in arr {
        sum1 += j[i]
    }
    arr2.append(sum1)
}

print(arr1.compactMap{ String($0) }.joined(separator: " "))
print(arr2.compactMap{ String($0) }.joined(separator: " "))

//print(arr1.joined(separator:"-"))
//print(arr2.joined(separator:"-"))





//enum PathT {
//    case TOP(Int)
//    case BOTTOM(Int)
//    case RIGHT(Int)
//    case LEFT(Int)
//
//    func get() -> String {
//            switch self {
//            case .TOP(let num):
//                return "TOP \(num)"
//            case .BOTTOM(let num):
//                return "BOTTOM \(num)"
//            case .RIGHT(let num):
//                return "RIGHT \(num)"
//            case .LEFT(let num):
//                return "LEFT \(num)"
//            }
//        }
//}
//
//
//
//var arr: [PathT] = []
//while let readString = readLine() {
//    if readString != "" {
//        let subArr = readString.components(separatedBy: " ")
//        switch subArr[0] {
//        case "TOP":
//            arr.append(PathT.TOP(Int(subArr[1])!))
//        case "BOTTOM":
//            arr.append(PathT.BOTTOM(Int(subArr[1])!))
//        case "RIGHT":
//            arr.append(PathT.RIGHT(Int(subArr[1])!))
//        case "LEFT":
//            arr.append(PathT.LEFT(Int(subArr[1])!))
//        default:
//            continue
//        }
//    }
//    else {
//        break
//    }
//}
//
////print(arr)
//var itogArr: [PathT] = [arr[0]]
//
//
//for i in 1..<arr.count {
//    switch arr[i] {
//    case .TOP(let b):
//        switch itogArr.last! {
//        case .TOP(let t):
//            itogArr.removeLast()
//            itogArr.append(PathT.TOP(b+t))
//        case .BOTTOM(let t):
//            itogArr.removeLast()
//            if b > t {
//                itogArr.append(PathT.TOP(b-t))
//            } else if b < t {
//                itogArr.append(PathT.BOTTOM(t-b))
//            }
//        case .RIGHT(_), .LEFT(_):
//            itogArr.append(PathT.TOP(b))
//        }
//
//    case .BOTTOM(let b):
//        switch itogArr.last! {
//        case .BOTTOM(let t):
//            itogArr.removeLast()
//            itogArr.append(PathT.BOTTOM(b+t))
//        case .TOP(let t):
//            itogArr.removeLast()
//            if b > t {
//                itogArr.append(PathT.BOTTOM(b-t))
//            } else if b < t {
//                itogArr.append(PathT.TOP(t-b))
//            }
//        case .RIGHT(_), .LEFT(_):
//            itogArr.append(PathT.BOTTOM(b))
//        }
//
//
//    case .LEFT(let b):
//        switch itogArr.last! {
//        case .LEFT(let t):
//            itogArr.removeLast()
//            itogArr.append(PathT.TOP(b+t))
//        case .RIGHT(let t):
//            itogArr.removeLast()
//            if b > t {
//                itogArr.append(PathT.LEFT(b-t))
//            } else if b < t {
//                itogArr.append(PathT.RIGHT(t-b))
//            }
//        case .TOP(_), .BOTTOM(_):
//            itogArr.append(PathT.LEFT(b))
//        }
//
//    case .RIGHT(let b):
//        switch itogArr.last! {
//        case .RIGHT(let t):
//            itogArr.removeLast()
//            itogArr.append(PathT.RIGHT(b+t))
//        case .LEFT(let t):
//            itogArr.removeLast()
//            if b > t {
//                itogArr.append(PathT.RIGHT(b-t))
//            } else if b < t {
//                itogArr.append(PathT.LEFT(t-b))
//            }
//        case .TOP(_), .BOTTOM(_):
//            itogArr.append(PathT.RIGHT(b))
//        }
//    }
//}
//
//for i in itogArr {
//    print(i.get())
//}

