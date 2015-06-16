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
    
    public func testUser() -> User {
        return User(dictionary: ["id": "fswYxDrqiG", "name": "pedro", "imageName": ""])
    }
    
    public func testPost(user: User) -> Post {
        return PostReport(dictionary: ["id": "6pGX8Owasd", "owner": user, "community": "GpMV5wxc37", "text": "teste 1", "status":"PostReportStatusOpen", "type": "PostContentTypeReport"])
    }
    
    public func createExpense(#type: ExpenseType, date: NSDate, totalExpense: NSNumber, community: Community, completionBlock: (expense: Expense?, error: NSError?) -> ()){
        
        let expenseObject = PFObject(className: "Expense")
        expenseObject["communityId"] = PFObject(withoutDataWithClassName: "Community", objectId: community.id)
        expenseObject["type"] = type.rawValue
        expenseObject["date"] = date
        expenseObject["totalExpense"] = totalExpense
        
        expenseObject.saveInBackgroundWithBlock({(success:Bool, error:NSError?) -> Void in
            if success{
                
                let expense = CondoApiMapper.expenseFromPFObject(expenseObject)
                
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
    
    public func createPost(#type: PostContentType, owner: User, text: String, status: PostReport.PostReportStatus, community: Community, completionBlock: (post: Post?, error: NSError?) -> ()) {
        
        let postObject              = PFObject(className: "Post")
        postObject["community"]     = PFObject(withoutDataWithClassName: "Community", objectId: community.id)
        postObject["owner"]         = PFObject(withoutDataWithClassName: "_User", objectId: owner.id)
        postObject["type"]          = type.rawValue
        postObject["text"]          = text
        postObject["totalComments"] = 0
        
        switch type {
        case .Report:
            postObject["status"] = status.rawValue
        default:
            postObject["status"] = ""
        }
        
        postObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            if success {
                
                let post = CondoApiMapper.postFromPFObject(postObject)
                
                if let post = post {
                    completionBlock(post: post, error: nil)
                }else{
                    completionBlock(post: nil, error: error)
                }
            }else{
                completionBlock(post: nil, error: error)
            }
        }
    }
    
    public func createComment(#owner: User, text: String, post: Post, completionBlock: (comment: Comment?, error: NSError?) -> ()){
        
        let commentObject = PFObject(className: "Comment")
        commentObject["owner"] = PFObject(withoutDataWithClassName: "_User", objectId: owner.id)
        commentObject["post"]  = PFObject(withoutDataWithClassName: "Post", objectId: post.id)
        commentObject["text"]  = text
        
        commentObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                
                let comment = CondoApiMapper.commentFromPFObject(commentObject)
                
                if let comment = comment {
                    completionBlock(comment: comment, error: nil)
                }else{
                    completionBlock(comment: nil, error: error)
                }
            }else{
                completionBlock(comment: nil, error: error)
            }
        }
    }
    
    public func getAllExpenses(#community: Community, completionBlock: (expenses: Array<Expense>?, error: NSError?) -> ()) {
        
        let query = PFQuery(className: "Expense")
        query.whereKey("communityId", equalTo: PFObject(withoutDataWithClassName: "Community", objectId: community.id))
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if let error = error{
                completionBlock(expenses: [], error: error)
            }else{
                
                if let objects = objects as? [PFObject]{
                    
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
    
    public func getAllPosts(#community: Community, completionBlock: (posts: Array<Post>?, error: NSError?) -> ()){
        
        let query = PFQuery(className: "Post")
        query.whereKey("community", equalTo: community.id)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if let error = error {
                completionBlock(posts: [], error: error)
            }else{
                
                if let objects = objects as? [PFObject] {
                    
                    var posts : Array<Post> = []
                    
                    for object in objects {
                        
                        let post = CondoApiMapper.postFromPFObject(object)
                        
                        if let post = post {
                            posts.append(post)
                        }
                    }
                    
                    completionBlock(posts: posts, error: nil)
                    
                }else{
                    completionBlock(posts: [], error: error)
                }
            }
        }
    }
}
