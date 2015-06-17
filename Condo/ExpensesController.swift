//
//  ExpensesController.swift
//  Condo
//
//  Created by Lucas Tenório on 17/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

let ExpensesControllerDataChangedNotification = "CondoExpensesControllerDataChangedNotification"
class ExpensesController: NSObject {
    private var _hasData = false
    private var expenseDictionary: Dictionary<ExpenseType, Array<Expense>> = [:]
    
    
    static let sharedController =  ExpensesController()
    var hasData: Bool {
        get {
            return self._hasData
        }
    }
    
    func fetchNewData() {
        
    }
    
    func getAllExpenseTypes() -> Array<ExpenseType> {
        return ExpenseType.allValues
    }
    
    func getAllExpenses(#type: ExpenseType) -> Array<Expense> {
        return []
    }
    
    func addExpense(#type: ExpenseType, totalExpense: NSNumber, date: NSDate) {
        
    }
}
