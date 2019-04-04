//
//  Unit.swift
//  UnitConverter
//
//  Created by Daheen Lee on 04/04/2019.
//  Copyright © 2019 allwhite. All rights reserved.
//

import Foundation

class Unit {
    var unitArray: [String] = []
    
    func convert(_ tuple: (sourceNum: Double, sourceUnit: String, destinationUnit: String?)) {
        let sourceNum  = tuple.sourceNum
        let sourceUnit = tuple.sourceUnit
        if let destinationUnit = tuple.destinationUnit { //19cm inch
            
            guard unitArray.contains(destinationUnit) else {
                print("지원하지 않는 단위입니다")
                return
            }
            
            f1(sourceNum: sourceNum, sourceUnit: sourceUnit, destinationUnit: destinationUnit)
        } else { //19cm
            f2(sourceNum: sourceNum, sourceUnit: sourceUnit)
        }
    }
    
    func f1(sourceNum: Double, sourceUnit: String, destinationUnit: String) {
        
    }
    
    func f2(sourceNum: Double, sourceUnit: String) {
        
    }
    
    
}

class Length: Unit{
    init(_ lengthUnitArray: [String]) {
        super.init()
        unitArray = lengthUnitArray
    }
    
    struct LengthBase {
        static let cmBase = 1.0
        static let mBase = 100.0
        static let inchBase = 2.54
        static let yardBase = 91.44
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
    
    override func f1(sourceNum: Double, sourceUnit: String, destinationUnit: String) {
        let convertedToCm = lengthUnitToCm(num: sourceNum, unit: sourceUnit)
        print("\(cmToLengthUnit(num: convertedToCm, unit: destinationUnit))\(destinationUnit)")
    }
    
    override func f2(sourceNum: Double, sourceUnit: String) {
        guard let unit = LengthUnit.init(rawValue: sourceUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        print(unit.convertDefaultValue(from: sourceNum))
    }
}

class Weight: Unit {
    init(_ weightUnitArray: [String]) {
        super.init()
        unitArray = weightUnitArray
    }
    struct WeightBase {
        static let gBase = 1.0
        static let kgBase = 1000.0
        static let lbBase = 453.592
        static let ozBase = 28.3495
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
    
    override func f1(sourceNum: Double, sourceUnit: String, destinationUnit: String) {
        let convertedToCm = weightUnitToG(num: sourceNum, unit: sourceUnit)
        print("\(gToWeightUnit(num: convertedToCm, unit: destinationUnit))\(destinationUnit)")
    }
    
    override func f2(sourceNum: Double, sourceUnit: String) {
        guard let unit = WeightUnit.init(rawValue: sourceUnit) else {
            print("지원하지 않는 단위입니다")
            return
        }
        print(unit.convertDefaultValue(from: sourceNum))
    }
}
