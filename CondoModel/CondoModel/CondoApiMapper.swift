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
    
    static func PFObjectFromExpenseDictionary(dictionary: Dictionary<String, AnyObject>, community: Community) ->PFObject {
        let expenseObject = PFObject(className: "Expense")
        expenseObject["communityId"] = PFObject(withoutDataWithClassName: "Community", objectId: community.id)
        expenseObject["type"] = dictionary["type"] as! String
        expenseObject["date"] = dictionary["expenseDate"] as! NSDate
        expenseObject["totalExpense"] = dictionary["totalExpense"] as! NSNumber
        return expenseObject
    }
    
    static func expenseFromPFObject(object: PFObject) -> Expense? {
        let dic :Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "type": object["type"]!,
            "totalExpense": object["totalExpense"]!,
            "expenseDate": object["date"]!
        ]
        return Expense(dictionary: dic)
    }
    
    static func postFromPFObject(object: PFObject) -> Post? {
        
        var dic: Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "type": object["type"]!,
            "owner": object["owner"]!,
            "community": object["community"]!,
            "text": object["text"]!
        ]
        
        let dicStatus : Dictionary<String, AnyObject> = [
            "status": object["status"]!
        ]
        
        if let type = PostContentType(rawValue: object["type"]! as! String) {
            switch type {
            case .Announcement:
                return PostAnnouncement(dictionary: dic)
            case .Question:
                return PostQuestion(dictionary: dic)
            case .Report:
                dic["status"] = object["status"]!
                return PostReport(dictionary: dic)
            }
        }
        
        return nil
    }
    
    static func commentFromPFObject(object:PFObject) -> Comment? {
        
        let dic:Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "owner": object["owner"]!,
            "post": object["post"]!,
            "text": object["text"]!
        ]
        
        return Comment(dictionary: dic)
    }
}
