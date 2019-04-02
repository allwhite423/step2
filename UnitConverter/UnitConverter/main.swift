//
//  main.swift
//  UnitConverter
//
//  Created by Daheen Lee on 02/04/2019.
//  Copyright © 2019 allwhite. All rights reserved.
//

import Foundation

let dividingNum = 100.0
func cmToM(cm: Double) -> Double {
    return Double(cm) / dividingNum
}

func mToCm(m: Double) -> Double {
    return m * dividingNum
}

func convert(userInput: String) -> String {
    guard let num = divideNumAndUnit(input: userInput).num else {
        return "변환이 불가능합니다"
    }
    let unit = divideNumAndUnit(input: userInput).unit
    if unit == "cm" {
        return "\(cmToM(cm: num))m"
    } else if unit == "m" {
        return "\(mToCm(m: num))cm"
    } else {
        return "지원하지 않는 단위입니다"
    }
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


print(convert(userInput: "120cm"))
print(convert(userInput: "1.2m"))
print(convert(userInput: "1"))
print(convert(userInput: "cm"))
print(convert(userInput: "1.."))


let test = "180cm inch"
var index = test.firstIndex(of: " ") ?? test.endIndex
print(test[..<index])
print(test[test.index(after: index)..<test.endIndex])

//print(convert(userInput: test))
