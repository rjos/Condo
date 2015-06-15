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
    case MaintenanceLift = "ExpenseTypeMaintenanceLift"
    case MaintenanceGenerator = "ExpenseTypeMaintenanceGenerator"
    case MaintenanceGarden = "ExpenseTypeMaintenanceGarden"
    case MaintenanceWell = "ExpenseTypeMaintenanceWell"
    case MaintenancePainting = "ExpenseTypeMaintenancePainting"
    
    public static let allValues: Array<ExpenseType> = [
        .Energy,
        .Water,
        .Personel,
        .Gas,
        .AdministrationCost,
        .Insurance,
        .Telephone,
        .CleaningServices,
        .CleaningMaterial,
        .MaintenanceLift,
        .MaintenanceGenerator,
        .MaintenanceGarden,
        .MaintenanceWell,
        .MaintenancePainting
    ]
    
}
public class Expense: Model {
    public let totalExpense : NSNumber
    public let type: ExpenseType
    public let expenseDate: NSDate
    override init(dictionary: Dictionary<String, AnyObject>) {
        self.totalExpense = dictionary["totalExpense"] as! NSNumber
        self.type = ExpenseType(rawValue: dictionary["type"] as! String)!
        self.expenseDate = dictionary["expenseDate"] as! NSDate
        super.init(dictionary: dictionary)
    }
}