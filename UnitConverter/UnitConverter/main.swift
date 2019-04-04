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

func startConvert(str: String) {
    
    let tuple = seperateNumAndUnit(input: str)
    let sourceUnit = tuple.sourceUnit
    
    var program: Unit = Unit()
    if lengthUnitArray.contains(sourceUnit){
        program = Length(lengthUnitArray)
//        convertLength(tuple)
    } else if weightUnitArray.contains(sourceUnit) {
        program = Weight(weightUnitArray)
//        convertWeight(tuple)
    } else {
        print("지원하지 않는 단위입니다.")
        return
    }
    program.convert(tuple)

}

func runMainMenu() {
    while let inputValue = readLine(), !inputValue.contains("q") {
        startConvert(str: inputValue)
    }
}

runMainMenu()

