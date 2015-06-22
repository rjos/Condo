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
    private var _hasData = false
    var expenseDictionary: Dictionary<ExpenseType, Array<Expense>> = [:]
    
    
    static let sharedController =  ExpensesController()
    var hasData: Bool {
        get {
            return self._hasData
        }
    }
    
    private func appendExpenseToBuffer(expense: Expense) {
        let type = expense.type
        var expenseArray = Array<Expense>()
        if let array = self.expenseDictionary[type] {
            expenseArray += array
        }
        expenseArray.append(expense)
        self.expenseDictionary[type] = expenseArray
    }
    
    private func deleteExpenseFromBuffer(id: String) {
        var newExpenseDictionary: Dictionary<ExpenseType, Array<Expense>> = [:]
        for (type, expenses) in self.expenseDictionary {
            newExpenseDictionary[type] = expenses.filter({$0.id != id})
        }
        self.expenseDictionary = newExpenseDictionary
    }
    
    func reloadData(#cached: Bool) {
        self._hasData = false
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        ParseDatabase.sharedDatabase.getAllExpenses(community: community, cachedResult: cached) { (expenses, error) -> () in
            if let expenses = expenses {
                self.expenseDictionary = [:]
                for expense in expenses {
                    self.appendExpenseToBuffer(expense)
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
    
    func deleteExpense(#id: String) {
        ParseDatabase.sharedDatabase.deleteExpense(id: id) {
            (success) in
            if success {
                self.deleteExpenseFromBuffer(id)
                self.postExpenseDeletedNotification()
            }
        }
    }
    
    func addExpense(#type: ExpenseType, totalExpense: NSNumber, date: NSDate) {
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        ParseDatabase.sharedDatabase.createExpense(type: type, date: date, totalExpense: totalExpense, community: community) { (expenseRaw, error) -> () in
            if let expense = expenseRaw {
                println("going to append expense \(expense) to buffer")
                self.appendExpenseToBuffer(expense)
                println("going to post notification")
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
