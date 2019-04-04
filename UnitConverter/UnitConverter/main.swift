//
//  main.swift
//  UnitConverter
//
//  Created by Daheen Lee on 02/04/2019.
//  Copyright © 2019 allwhite. All rights reserved.
//

import Foundation


let lengthUnitArray = ["cm", "m", "inch", "yard"]
let weightUnitArray = ["g", "kg", "lb", "oz"]

struct LengthBase {
    static let cmBase = 1.0
    static let mBase = 100.0
    static let inchBase = 2.54
    static let yardBase = 91.44
}

struct WeightBase {
    static let gBase = 1.0
    static let kgBase = 1000.0
    static let lbBase = 453.592
    static let ozBase = 28.3495
}

enum LengthUnit: String {
    
    case cm = "cm"
    case m = "m"
    case inch = "inch"
    case yard = "yard"
    
    func convertDefaultValue(from sourceNum: Double) -> String {
        
        switch self {
        case .cm:
            return "\(sourceNum / LengthBase.mBase)m"
        case .m:
            return "\(sourceNum * LengthBase.mBase)cm"
        case .inch:
            return "\(sourceNum * LengthBase.inchBase)cm"
        case .yard:
            return "\(sourceNum * LengthBase.yardBase / LengthBase.mBase)m"
        }
    }
}

enum WeightUnit: String {
    
    case g = "g"
    case kg = "kg"
    case lb = "lb"
    case oz = "oz"
    
    func convertDefaultValue(from sourceNum: Double) -> String {
        
        switch self {
        case .g:
            return "\(sourceNum / WeightBase.kgBase)kg"
        case .kg:
            return "\(sourceNum * WeightBase.kgBase)g"
        case .lb:
            return "\(sourceNum * WeightBase.lbBase)g"
        case .oz:
            return "\(sourceNum * WeightBase.ozBase)g"
        }
    }
}

func cmToLengthUnit(num: Double, unit: String) -> Double {

    guard let sourceUnit = LengthUnit(rawValue: unit) else {
        return Double()
    }

    switch sourceUnit {
    case .cm:
        return num / LengthBase.cmBase
    case .m:
        return num / LengthBase.mBase
    case .inch:
        return num / LengthBase.inchBase
    case .yard:
        return num / LengthBase.yardBase
    }
}

func lengthUnitToCm(num: Double, unit: String) -> Double {
    
    guard let unit = LengthUnit(rawValue: unit) else {
        return 0
    }
    
    switch unit {
    case .cm:
        return num * LengthBase.cmBase
    case .m:
        return num * LengthBase.mBase
    case .inch:
        return num * LengthBase.inchBase
    case .yard:
        return num * LengthBase.yardBase
    }
}

func gToWeightUnit(num: Double, unit: String) -> Double {
    guard let sourceUnit = WeightUnit(rawValue: unit) else {
        return Double()
    }
    
    switch sourceUnit {
    case .g:
        return num / WeightBase.gBase
    case .kg:
        return num / WeightBase.kgBase
    case .lb:
        return num / WeightBase.lbBase
    case .oz:
        return num / WeightBase.ozBase
    }
}

func weightUnitToG(num: Double, unit: String) -> Double {
    guard let sourceUnit = WeightUnit(rawValue: unit) else {
        return Double()
    }
    
    switch sourceUnit {
    case .g:
        return num * WeightBase.gBase
    case .kg:
        return num * WeightBase.kgBase
    case .lb:
        return num * WeightBase.lbBase
    case .oz:
        return num * WeightBase.ozBase
    }
}

func seperateByGap(of input: String) -> [String] {
    return input.components(separatedBy: " ")
}

func seperateNumAndUnit(input: String) -> (sourceNum: Double, sourceUnit: String, destinationUnit: String?) {
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


fileprivate func convertLength(_ tuple: (sourceNum: Double, sourceUnit: String, destinationUnit: String?)) {
    let sourceNum  = tuple.sourceNum
    let sourceUnit = tuple.sourceUnit
    if let destinationUnit = tuple.destinationUnit { //19cm inch
        
        guard lengthUnitArray.contains(destinationUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        
        let convertedToCm = lengthUnitToCm(num: sourceNum, unit: sourceUnit)
        print("\(cmToLengthUnit(num: convertedToCm, unit: destinationUnit))\(destinationUnit)")
    } else { //19cm
        guard let unit = LengthUnit.init(rawValue: sourceUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        print(unit.convertDefaultValue(from: sourceNum))
    }
}

fileprivate func convertWeight(_ tuple: (sourceNum: Double, sourceUnit: String, destinationUnit: String?)) {
    let sourceNum  = tuple.sourceNum
    let sourceUnit = tuple.sourceUnit
    if let destinationUnit = tuple.destinationUnit { //19cm inch
        
        guard weightUnitArray.contains(destinationUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        
        let convertedToCm = weightUnitToG(num: sourceNum, unit: sourceUnit)
        print("\(gToWeightUnit(num: convertedToCm, unit: destinationUnit))\(destinationUnit)")
    } else { //19cm
        guard let unit = WeightUnit.init(rawValue: sourceUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        print(unit.convertDefaultValue(from: sourceNum))
    }
}

func startConvert(str: String) {
    
    let tuple = seperateNumAndUnit(input: str)
    let sourceUnit = tuple.sourceUnit
    if lengthUnitArray.contains(sourceUnit){
        convertLength(tuple)
    } else if weightUnitArray.contains(sourceUnit) {
        convertWeight(tuple)
    } else {
        print("지원하지 않는 단위입니다.")
    }

}

func runMainMenu() {
    while let inputValue = readLine(), !inputValue.contains("q") {
        startConvert(str: inputValue)
    }
}

runMainMenu()

