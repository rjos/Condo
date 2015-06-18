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
        
        return User(dictionary: [
            "id": "YwUtjZt51Z",
            "name": "pedro",
            "imageName": "dummy-photo-pedro",
            "image": ""])
    }
    
    public func testPost(user: User, community: Community) -> Post {
        return PostReport(dictionary: [
            "id": "wTVodyGdYU",
            "owner": user,
            "community": community,
            "text": "teste 1",
            "status":"PostReportStatusOpen",
            "type": "PostContentTypeReport",
            "totalComments": 1
            ])
    }
    
    public func createExpenses(#expenses: Array<Dictionary<String, AnyObject>>, community: Community, completionBlock: (expenses: Array<Expense>?, error: NSError?) -> ()) {
        var expensePFObjects: Array<PFObject> = []
        for expenseDictionary in expenses {
            let expense = CondoApiMapper.PFObjectFromExpenseDictionary(expenseDictionary, community: community)
            expensePFObjects.append(expense)
        }
        PFObject.saveAllInBackground(expensePFObjects, block: { (success, error) -> Void in
            if success {
                var result: Array<Expense> = []
                for object in expensePFObjects {
                    result.append(CondoApiMapper.expenseFromPFObject(object)!)
                }
                completionBlock(expenses: result, error: error)
            }else{
                completionBlock(expenses: nil, error: error)
            }
        })
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
                
                let post = CondoApiMapper.postFromPFObject(postObject, user: owner, community: community)
                
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
                
                let comment = CondoApiMapper.commentFromPFObject(commentObject, user: owner, post: post)
                
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
        query.whereKey("community", equalTo: PFObject(withoutDataWithClassName: "Community", objectId: community.id))
        query.includeKey("owner")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if let error = error {
                completionBlock(posts: [], error: error)
            }else{
                
                if let objects = objects as? [PFObject] {
                    
                    var posts : Array<Post> = []
                    
                    for object in objects {
                        
                        let owner = object["owner"] as! PFUser
                        
                        let userPost = CondoApiMapper.userFromPFObject(owner)
                        
                        if let userPost = userPost {
                            
                            let post = CondoApiMapper.postFromPFObject(object, user: userPost, community: community)
                            
                            if let post = post {
                                posts.append(post)
                            }
                        }
                    }
                    
                    completionBlock(posts: posts, error: nil)
                    
                }else{
                    completionBlock(posts: [], error: error)
                }
            }
        }
    }
    
    public func getCommentFromPost(post: Post, completionBlock: (comments: Array<Comment>?, error: NSError?) -> ()) {
        
        let commentsObject = PFQuery(className: "Comment")
        commentsObject.includeKey("onwer")
        commentsObject.whereKey("post", equalTo: PFObject(withoutDataWithClassName: "Post", objectId: post.id))
        commentsObject.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if let objects = (objects as? [PFObject]){
                
                var comments : Array<Comment> = []
                
                for object in objects {
                    
                    let user = object["owner"] as! PFUser
                    
                    let ownerPost = CondoApiMapper.userFromPFObject(user)
                    
                    if let ownerPost = ownerPost {
                        
                        let comment = CondoApiMapper.commentFromPFObject(object, user: ownerPost, post: post)
                        
                        if let comment = comment {
                            comments.append(comment)
                        }
                    }
                }
                
                completionBlock(comments: comments, error: nil)
                
            }else{
                completionBlock(comments: [], error: error)
            }
        }
    }
}
