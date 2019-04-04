//
//  main.swift
//  UnitConverter
//
//  Created by Daheen Lee on 02/04/2019.
//  Copyright © 2019 allwhite. All rights reserved.
//

import Foundation

struct LengthConversionBaseValue {
    let cmBase = 1.0
    let mBase = 100.0
    let inchBase = 2.54
    let yardBase = 91.44
}

let legthUnitDictionary = ["cm", "m", "inch", "yard"]

enum LengthUnit: String {
    case cm = "cm"
    case m = "m"
    case inch = "inch"
    case yard = "yard"
    
    func convertDefaultValue(sourceNum: Double) -> String {
        
        switch self {
        case .cm:
            return "\(sourceNum / baseValue.mBase)m"
        case .m:
            return "\(sourceNum * baseValue.mBase)cm"
        case .inch:
            return "\(sourceNum * baseValue.inchBase)cm"
        case .yard:
            return "\(sourceNum * baseValue.yardBase / baseValue.mBase)m"
        }
    }
}

    let baseValue = LengthConversionBaseValue()



func cmToLengthUnit(num: Double, unit: String) -> String {

    guard let sourceUnit = LengthUnit(rawValue: unit) else {
        return String()
    }

    switch sourceUnit {
    case .cm:
        return "\(num / baseValue.cmBase)" + unit
    case .m:
        return "\(num / baseValue.mBase)" + unit
    case .inch:
        return "\(num / baseValue.inchBase)" + unit
    case .yard:
        return "\(num / baseValue.yardBase)" + unit
    }
}

func lengthUnitToCm(num: Double, destinationUnit: String) -> Double {
    
    guard let destinationUnit = LengthUnit(rawValue: destinationUnit) else {
        return 0
    }
    
    switch destinationUnit {
    case .cm:
        return num * baseValue.cmBase
    case .m:
        return num * baseValue.mBase
    case .inch:
        return num * baseValue.inchBase
    case .yard:
        return num * baseValue.yardBase
    }
}


func seperateByGap(of input: String) -> [String] {
    return input.components(separatedBy: " ")
}

func seperateNumAndUnit(input: String) -> (sourceNum: Double, souceUnit: String, destinationUnit: String?) {
    let characterSet: String = "abcdefghijklmnopqrstuvwxyz"
    var inputNum = String()
    var inputUnit = String()
    let destUnit: String?
    let inputArray = seperateByGap(of: input)
    
    if inputArray.count > 0 {
        for char in inputArray[0] {
            if !characterSet.contains(char) {
                inputNum.append(char)
            } else {
                inputUnit.append(char)
            }
        }
    }
    
    if let inputNum = Double(inputNum) {
        if inputArray.count == 1 {
            destUnit = nil
            return (inputNum, inputUnit, destUnit)
        } else if inputArray.count == 2 {
            destUnit = inputArray[1]
            return (inputNum, inputUnit, destUnit)
        }
    }
    return (0,"", "")
}


func startConvert(str: String) {
    
    let tuple = seperateNumAndUnit(input: str)
    let sourceNum  = tuple.sourceNum
    let sourceUnit = tuple.souceUnit
    if let destinationUnit = tuple.destinationUnit { //19cm inch
        guard legthUnitDictionary.contains(destinationUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        let convertedToCm = lengthUnitToCm(num: sourceNum, destinationUnit: sourceUnit)
        print(cmToLengthUnit(num: convertedToCm, unit: destinationUnit))
    } else { //19cm
        guard let unit = LengthUnit.init(rawValue: sourceUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        print(unit.convertDefaultValue(sourceNum: sourceNum))
    }
    
}

func runMainMenu() {
    while let inputValue = readLine(), !inputValue.contains("q") {
        startConvert(str: inputValue)
    }
}

runMainMenu()

