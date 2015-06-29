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
    
    static func userFromPFObject(object: PFUser) -> User? {
        
        var dic: Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "name": object["fullname"]!,
            "imageName": "dummy-photo-pedro",
            "email": object.username!
        ]
        
        if let apt = object["apt"] as? String {
            dic["apt"] = apt
        }else{
            dic["apt"] = nil
        }
        
        if let community = object["community"] as? PFObject {
            
            dic["community"] = self.communityFromPFObject(community)!
        }else{
            dic["community"] = nil
        }
        
        if let imageFile = (object["image"] as? PFFile) {
            
            dic["image"] = imageFile
        }else{
            dic["image"] = nil
        }
        
        return User(dictionary: dic)
    }
    
    static func communityFromPFObject(object: PFObject) -> Community? {
        
        let dictionary: Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "name": object["name"]!,
            "administrators": object["administrators"]!
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
    
    static func postFromPFObject(object: PFObject, user: User, community: Community) -> Post? {
        
        var dic: Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "type": object["type"]!,
            "owner": user,
            "community": community,
            "text": object["text"]!,
            "totalComments": object["totalComments"]!
        ]
        
        let dicStatus : Dictionary<String, AnyObject> = [
            "status": object["status"]!
        ]
        
        if let type = PostContentType(rawValue: object["type"]! as! String) {
            switch type {
            case .Announcement:
                return PostAnnouncement(dictionary: dic)
            case .Question:
                if let agree = object["totalAgree"], disagree = object["totalDisagree"] {
                    dic["totalAgree"] = agree
                    dic["totalDisagree"] = disagree
                } else{
                    dic["totalAgree"] = 0
                    dic["totalDisagree"] = 0
                }
                
                return PostQuestion(dictionary: dic)
            case .Report:
                dic["status"] = object["status"]!
                return PostReport(dictionary: dic)
            }
        }
        
        return nil
    }
    
    static func commentFromPFObject(object:PFObject, user:User, post: Post) -> Comment? {
        let dic:Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "owner": user,
            "post": post,
            "text": object["text"]!
        ]
        return Comment(dictionary: dic)
    }
    
    static func questionAnswerFromPFObject(object: PFObject, user: User, post: PostQuestion) -> PostQuestionAnswer? {
        var dic:Dictionary<String, AnyObject> = [
            "id": object.objectId!,
            "owner": user,
            "post": post
        ]
        if let answerString = object["typeAnswer"] as? String {
            dic["status"] = answerString
        }else{
            dic["status"] = PostQuestionAnswer.PostQuestionAnswerStatus.NoAnswer.rawValue
        }
        return PostQuestionAnswer(dictionary: dic)
    }
}
