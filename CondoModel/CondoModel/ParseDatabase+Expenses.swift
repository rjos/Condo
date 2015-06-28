//
//  ParseDatabase+Expenses.swift
//  CondoModel
//
//  Created by Lucas Tenório on 28/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

public extension ParseDatabase {
    
    public func getAllExpenses(#community: Community, cachedResult: Bool, completionBlock: (expenses: Array<Expense>?, error: NSError?) -> ()) {
        
        let query = PFQuery(className: "Expense")
        query.whereKey("communityId", equalTo: PFObject(withoutDataWithClassName: "Community", objectId: community.id))
        query.orderByDescending("date")
        if cachedResult {
            query.fromLocalDatastore()
        }
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if let error = error{
                completionBlock(expenses: nil, error: error)
            }else{
                if let objects = objects as? [PFObject]{
                    if cachedResult {
                        if objects.count == 0 {
                            self.getAllExpenses(community: community, cachedResult: false, completionBlock: completionBlock)
                            return
                        }
                    }else{
                        PFObject.pinAllInBackground(objects)
                    }
                    var expenses : Array<Expense> = []
                    for object in objects{
                        let expense = CondoApiMapper.expenseFromPFObject(object)
                        if let expense = expense {
                            expenses.append(expense)
                        }
                    }
                    completionBlock(expenses: expenses, error: nil)
                }else{
                    completionBlock(expenses: [], error: error)
                }
            }
        }
    }
    
    public func createExpense(#type: ExpenseType, date: NSDate, totalExpense: NSNumber, community: Community, completionBlock: (expense: Expense?, error: NSError?) -> ()){
        let d = Expense.dictionary(type: type, date: date, totalExpense: totalExpense)
        self.createExpenses(expenses: [d], community: community) { (expenses, error) -> () in
            if let e = expenses {
                completionBlock(expense: e[0], error: error)
            }else{
                completionBlock(expense: nil, error: error)
            }
        }
    }
    
    public func createExpenses(#expenses: Array<Dictionary<String, AnyObject>>, community: Community, completionBlock: (expenses: Array<Expense>?, error: NSError?) -> ()) {
        var expensePFObjects: Array<PFObject> = []
        for expenseDictionary in expenses {
            let expense = CondoApiMapper.PFObjectFromExpenseDictionary(expenseDictionary, community: community)
            expensePFObjects.append(expense)
        }
        
        PFObject.saveAllInBackground(expensePFObjects, block: { (success, error) -> Void in
            if success {
                PFObject.pinAllInBackground(expensePFObjects, block: { (pinSuccess, pinError) -> Void in
                    if pinSuccess {
                        var result: Array<Expense> = []
                        for object in expensePFObjects {
                            result.append(CondoApiMapper.expenseFromPFObject(object)!)
                        }
                        completionBlock(expenses: result, error: error)
                    }
                })
                
            }else{
                completionBlock(expenses: nil, error: error)
            }
        })
    }
    
    public func deleteExpense(#id: String, completionHandler: (Bool) -> ()) {
        let expense = PFObject(withoutDataWithClassName: "Expense", objectId: id)
        expense.unpinInBackgroundWithBlock { (success, error) -> Void in
            if success {
                expense.deleteEventually()
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
}
