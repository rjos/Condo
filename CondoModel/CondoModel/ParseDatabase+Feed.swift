//
//  ParseDatabase+Feed.swift
//  CondoModel
//
//  Created by Lucas Tenório on 28/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

public extension ParseDatabase {
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
    
    public func createAnswer(owner: User, typeAnswer: PostQuestionAnswer.PostQuestionAnswerStatus, post: Post, completionBlock: (answer: PostQuestionAnswer?, error: NSError?) -> ()){
        
        let answerObject = PFObject(className: "QuestionAnswer")
        answerObject["owner"] = PFObject(withoutDataWithClassName: "_User", objectId: owner.id)
        answerObject["typeAnswer"] = typeAnswer.rawValue
        answerObject["post"] = PFObject(withoutDataWithClassName: "Post", objectId: post.id)
        
        answerObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                if let answer = CondoApiMapper.questionAnswerFromPFObject(answerObject, user: owner, post: post) {
                    completionBlock(answer: answer, error: nil)
                }else{
                    completionBlock(answer: nil, error: error)
                }
            }else{
                completionBlock(answer: nil, error: error)
            }
        }
    }
    
    public func getAllPostTest(user: User, community: Community) {
        
        PFCloud.callFunctionInBackground("allPosts", withParameters: ["user": user.id, "community": community.id]) {
            (response: AnyObject?, error: NSError?) -> Void in
            // ratings is 4.5
            if let response = (response as? Array<AnyObject>) {
                
                for resp in response {
                    
                    if let resp = (resp as? Dictionary<String, PFObject>) {
                        for (key, object) in resp {
                            println("Key (\(key)),object(\(object))")
                        }
                        if let post = resp["post"] {
                            
                            var user = CondoApiMapper.userFromPFObject(post["owner"] as! PFUser)
                            
                            if let user = user {
                                
                                println(user)
                            }
                        }
                    }else {
                        println("---------------------------------")
                        println(resp)
                        if let resp = resp as? Dictionary<String, AnyObject> {
                            for (key, object) in resp {
                                println("Key (\(key)),object(\(object))")
                            }
                        }
                        println("---------------------------------")
                    }
                }
            }
        }
    }
    
    public func getAllPosts(#community: Community, completionBlock: (posts: Array<Post>?, error: NSError?) -> ()){
        
        let query = PFQuery(className: "Post")
        query.whereKey("community", equalTo: PFObject(withoutDataWithClassName: "Community", objectId: community.id))
        query.includeKey("owner")
        query.orderByDescending("createdAt")
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
        commentsObject.includeKey("owner")
        commentsObject.whereKey("post", equalTo: PFObject(withoutDataWithClassName: "Post", objectId: post.id))
        commentsObject.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
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
