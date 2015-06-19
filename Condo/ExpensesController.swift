//
//  ExpensesController.swift
//  Condo
//
//  Created by Lucas Tenório on 17/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

import Parse



class ExpensesController: NSObject {

    enum ExpenseServerAction {
        case Delete(id: String)
        case Add(id: String, type: ExpenseType, totalExpense: NSNumber, date: NSDate)
    }
    private var _hasData = false
    var expenseDictionary: Dictionary<ExpenseType, Array<Expense>> = [:]
    
    
    static let sharedController =  ExpensesController()
    var hasData: Bool {
        get {
            return self._hasData
        }
    }
    
    func reloadData(#cached: Bool) {
        self._hasData = false
        let community = ParseDatabase.sharedDatabase.testCommunity()
        ParseDatabase.sharedDatabase.getAllExpenses(community: community, cachedResult: cached) { (expenses, error) -> () in
            if let expenses = expenses {
                self.expenseDictionary = [:]
                for expense in expenses {
                    let type = expense.type
                    var expenseArray: Array<Expense>
                    if let array = self.expenseDictionary[type] {
                        expenseArray = Array<Expense>(array)
                    } else {
                        expenseArray = Array<Expense>()
                    }
                    expenseArray.append(expense)
                    self.expenseDictionary[type] = expenseArray
                }
                self._hasData = true
                self.postDataChangedNotification()
            }
        }
    }
    
    func getAllExpenseTypes() -> Array<ExpenseType> {
        return ExpenseType.allValues
    }
    
    func getAllExpenses(#type: ExpenseType) -> Array<Expense> {
        if let result = self.expenseDictionary[type] {
            return result
        }
        return Array<Expense>()
    }
    

    
    func addExpense(#type: ExpenseType, totalExpense: NSNumber, date: NSDate) {
        let community = ParseDatabase.sharedDatabase.testCommunity()
        ParseDatabase.sharedDatabase.createExpense(type: type, date: date, totalExpense: totalExpense, community: community) { (expenseRaw, error) -> () in
            if let expense = expenseRaw {
                self.postExpenseAddedNotification()
            }
        }
    }
    
    
    
    //MARK: - Notifications
    static let DataChangedNotification = "CondoExpensesControllerDataChangedNotification"
    static let ExpenseAddedNotification = "CondoExpensesControllerExpenseAddedNotification"
    static let ExpenseDeletedNotification = "CondoExpensesControllerExpenseDeletedNotification"
    
    private func postExpenseDeletedNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(ExpensesController.ExpenseDeletedNotification, object: self, userInfo: nil)
        self.postDataChangedNotification()
    }
    
    private func postExpenseAddedNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(ExpensesController.ExpenseAddedNotification, object: self, userInfo: nil)
        self.postDataChangedNotification()
    }
    
    private func postDataChangedNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(ExpensesController.DataChangedNotification, object: self, userInfo: nil)
    }
}
