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
        let community = ParseDatabase.sharedDatabase.testCommunity()
        ParseDatabase.sharedDatabase.getAllExpenses(community: community) { (expenses, error) -> () in
            if let expenses = expenses {
                self.expenseDictionary = [:]
                for expense in expenses {
                    let type = expense.type
                    var expenseArray: Array<Expense>
                    if let array = self.expenseDictionary[type] {
                        expenseArray = array
                    } else {
                        expenseArray = []
                    }
                    expenseArray.append(expense)
                    self.expenseDictionary[type] = expenseArray
                }
                NSNotificationCenter.defaultCenter().postNotificationName(ExpensesControllerDataChangedNotification, object: self, userInfo: nil)
            }
        }
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
