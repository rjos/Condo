//
//  CondoApiMapper.swift
//  CondoModel
//
//  Created by Lucas Tenório on 15/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import Parse

class CondoApiMapper: NSObject {
    static func communityFromPFObject(object: PFObject) -> Community? {
        
        let dictionary: Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "name": object["name"]!,
            "administratorID": object["administrator"]!
        ]
        return Community(dictionary: dictionary)
    }
    
    static func expenseFromPFOBject(object: PFObject) -> Expense? {
        let dic :Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "type": object["type"]!,
            "totalExpense": object["totalExpense"]!,
            "expenseDate": object["date"]!
        ]
        
        let newExpense: Expense = Expense(dictionary: dic)
        return nil
    }
}
