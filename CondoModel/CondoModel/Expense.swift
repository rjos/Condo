//
//  Expense.swift
//  CondoModel
//
//  Created by Lucas Tenório on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

public enum ExpenseType: String{
    case Water = "ExpenseTypeWater"
    case Energy = "ExpenseTypeEnergy"
    case Personel = "ExpenseTypePersonel"
    case Gas = "ExpenseTypeGas"
    case AdministrationCost = "ExpenseTypeAdministrationCost"
    case Insurance = "ExpenseTypeInsurance"
    case Telephone = "ExpenseTypeTelephone"
    case CleaningServices = "ExpenseTypeCleaningServices"
    case CleaningMaterial = "ExpenseTypeCleaningMaterial"
}
public class Expense: Model {
    public let totalExpense : NSDecimalNumber
    public let type: ExpenseType
    public let expenseDate: NSDate
    override init(dictionary: Dictionary<String, AnyObject>) {
        self.totalExpense = dictionary["totalExpense"] as! NSDecimalNumber
        self.type = ExpenseType(rawValue: dictionary["type"] as! String)!
        self.expenseDate = dictionary["expenseDate"] as! NSDate
        super.init(dictionary: dictionary)
    }
}


extension NSDecimalNumber: Comparable {}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

// MARK: - Arithmetic Operators

public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.decimalNumberByMultiplyingBy(NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByAdding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberBySubtracting(rhs)
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByMultiplyingBy(rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByDividingBy(rhs)
}

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberByRaisingToPower(rhs)
}
