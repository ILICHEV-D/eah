
import Foundation
  
var arr: [String] = []

if let path = Bundle.main.path(forResource: "input", ofType: "txt") {
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        arr = data.components(separatedBy: .newlines)
    } catch {
        print(error)
    }
}
arr.removeLast()
var dictionary: [Int: String] = [:]


for i in arr {
    var intString = ""
    var charString = ""
    for char in i {
        if char.isNumber {
            intString.append(char)
        } else {
            charString.append(char)
        }
    }
    dictionary[Int(intString)!] = charString
}

let sortedDict = dictionary.sorted(by: {$0.key < $1.key})
sortedDict
let file = "file.txt" //this is the file. we will write to and read from it


//if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//    let fileURL = dir.appendingPathComponent(file)
//
//    //writing
//    do {
//        try text.write(to: fileURL, atomically: false, encoding: .utf8)
//    }
//    catch {/* error handling here */}
//
//    //reading
//    do {
//        let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//    }
//    catch {/* error handling here */}
//}

if let path = Bundle.main.path(forResource: "output", ofType: "txt") {
    do {
        try text.write(to: URL(fileURLWithPath: path), atomically: false, encoding: .utf8)
    } catch {
        print(error)
        print("aaa")
    }
}

//try? text.write(toFile: "input.txt", atomically: true, encoding: .utf8)
