//
//  ParseDatabase.swift
//  CondoModel
//
//  Created by Rodolfo José on 15/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import Parse
import Bolts

public class ParseDatabase: NSObject {
   
    public static let sharedDatabase = ParseDatabase()
    
    public func setup(){
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("frhoWZOYHwsv5M6bTlBgbnsKb4MteIZle69dovkh",
            clientKey: "EC0xXL6isxFFX64o8sDFREmRHZ6nBe0kJlZ76Al2")
    }
    
    public func createCommunity(name: String, administratorID: String ,completionBlock: (community: Community?, error: NSError?) -> ()){
        
        let testObject = PFObject(className: "Community")
        testObject["name"] = name
        testObject["administratorID"] = administratorID
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println(testObject.objectId)
            if success {
                
                let community = CondoApiMapper.communityFromPFObject(testObject)
                
                if let community = community {
                    completionBlock(community: community, error: error)
                }else{
                    completionBlock(community: nil, error: error)
                }
            }else{
                completionBlock(community: nil, error: error)
            }
        }
    }
    
    public func testCommunity()->Community {
        return Community(dictionary: ["id":"GpMV5wxc37", "name":"Ed. Santiago", "administratorID":"1234"])
    }
    
    public func createExpense(#type: ExpenseType, date: NSDate, totalExpense: NSNumber, community: Community, completionBlock: (expense: Expense?, error: NSError?) -> ()){
        
        let expenseObject = PFObject(className: "Expense")
        expenseObject["communityId"] = PFObject(withoutDataWithClassName: "Community", objectId: community.id)
        expenseObject["type"] = type.rawValue
        expenseObject["date"] = date
        expenseObject["totalExpense"] = totalExpense
        
        expenseObject.saveInBackgroundWithBlock({(success:Bool, error:NSError?) -> Void in
            if success{
                
                let expense = CondoApiMapper.expenseFromPFOBject(expenseObject)
                
                if let expense = expense {
                    completionBlock(expense: expense, error: error)
                }else{
                    completionBlock(expense: nil, error: error)
                }
            }else{
                completionBlock(expense: nil, error: error)
            }
        })
    }
    
    public func getAllExpenses(#community: Community, completionBlock: (expense: Array<Expense>?, error: NSError?) -> ()) {
        completionBlock(expense: [], error: nil)
    }
}
