//
//  main.swift
//  UnitConverter
//
//  Created by Daheen Lee on 02/04/2019.
//  Copyright © 2019 allwhite. All rights reserved.
//

import Foundation

let mCm = 100.0
let inchCm = 2.54
let yardCm = 91.44

func cmToM(cm: Double) -> Double {
    return Double(cm) / mCm
}

func mToCm(m: Double) -> Double {
    return m * mCm
}

func inchToCm(inch: Double) -> Double {
    return inch * inchCm
}

func cmToInch(cm: Double) -> Double {
    return cm / inchCm
}

func yardTocm(yard: Double) -> Double {
    return yard * yardCm
}

func cmToYard(cm: Double) -> Double {
    return cm / yardCm
}

func convert(userInput: String) -> String {
    let dividedInput: [String] = seperateByGap(of: userInput)
    
    let from = dividedInput[0]
    
    guard let num = divideNumAndUnit(input: from).num else {
        return "변환이 불가능합니다"
    }
    let unit = divideNumAndUnit(input: from).unit
    
    if dividedInput.count == 2 {
        let to = dividedInput[1]
        return switchUnit(num: num, from: unit, to: to)
    } else {
        return switchUnit(num: num, from: unit, to: nil)
    }
    
    
}

func switchUnit(num: Double, from: String, to: String?) -> String {
    
    if to == nil {
        if from == "cm" {
            return "\(cmToM(cm: num))m"
        } else if from == "m" {
            return "\(mToCm(m: num))cm"
        } else if from == "inch" {
            return "\(inchToCm(inch: num))cm"
        } else if from == "yard" {
            return "\(cmToM(cm: yardTocm(yard: num)))m"
        } else {
            return "지원하지 않는 단위입니다"
        }
    } else {
        switch (from, to) {
        case ("cm", "m"):
             return "\(cmToM(cm: num))m"
        case("cm", "inch"):
            return "\(cmToInch(cm: num))inch"
        case("cm", "yard"):
            return "\(cmToYard(cm: num))yard"
        case("m", "cm"):
             return "\(mToCm(m: num))cm"
        case("m", "inch"):
            return "\(cmToInch(cm: mToCm(m: num)))m"
        case("m", "yard"):
            return "\(cmToYard(cm: mToCm(m: num)))yard"
        case("inch", "cm"):
             return "\(inchToCm(inch: num))cm"
        case("inch", "m"):
             return "\(inchToCm(inch: cmToM(cm: num)))cm"
        case ("inch", "yard"):
            return "\(cmToYard(cm: inchToCm(inch: num)))yard"
        case("yard", "cm"):
            return "\(yardTocm(yard: num))cm"
        case ("yard", "m"):
            return "\(cmToM(cm: yardTocm(yard: num)))m"
        case ("yard", "inch"):
            return "\(cmToInch(cm: yardTocm(yard: num)))inch"
        default:
            return "지원하지 않는 단위입니다."
        }
    }
    
    
}

func seperateByGap(of input: String) -> [String] {
    return input.components(separatedBy: " ")
}

func divideNumAndUnit(input: String) -> (num: Double?, unit: String) {
    let characterSet: String = "abcdefghijklmnopqrstuvwxyz"
    var convertInputUnit = ""
    var convertInputNum = ""
    
    for char in input
    {
        if !characterSet.contains(char)
        {
            convertInputNum.append(char)
        }
        else
        {
            convertInputUnit.append(char)
        }
    }
    
    if let convertedNum = Double(convertInputNum) {
        return (convertedNum, convertInputUnit)
    } else {
        return (nil, convertInputUnit)
    }
}


//print(convert(userInput: "120cm"))
//print(convert(userInput: "1.2m"))
//print(convert(userInput: "1"))
//print(convert(userInput: "cm"))
//print(convert(userInput: "1.."))
//
//
//let test = "180cm inch"
//var index = test.firstIndex(of: " ") ?? test.endIndex
//print(test[..<index])
//print(test[test.index(after: index)..<test.endIndex])
//
//print(test.components(separatedBy: " "))
//
//print(convert(userInput: test))
//print(convert(userInput: "2.54yard"))
//print(convert(userInput: "2.54yard cm"))

//guard let inputValue = readLine() else {
//    fatalError()
//}
//var input = ""
//repeat {
//    if let inputValue = readLine(), !inputValue.contains("q") {
//        print(convert(userInput: inputValue))
//    }
//    input = inputValue
//} while !input.contains("q")

while let inputValue = readLine(), !inputValue.contains("q") {
    print(convert(userInput: inputValue))
}

//print(inputValue)quit
