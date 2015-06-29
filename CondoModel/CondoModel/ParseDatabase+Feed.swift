//
//  ParseDatabase+Feed.swift
//  CondoModel
//
//  Created by Lucas Tenório on 28/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

let feedPinName = "CondoFeedPinName"
public extension ParseDatabase {
    public func createPost(#type: PostContentType, owner: User, text: String, status: PostReport.PostReportStatus, community: Community, completionBlock: (post: Post?, error: NSError?) -> ()) {
        
        let postObject              = PFObject(className: "Post")
        postObject["community"]     = PFObject(withoutDataWithClassName: "Community", objectId: community.id)
        postObject["owner"]         = PFObject(withoutDataWithClassName: "_User", objectId: owner.id)
        postObject["type"]          = type.rawValue
        postObject["text"]          = text
        postObject["totalComments"] = 0
        postObject["totalAgree"] = 0
        postObject["totalDisagree"] = 0
        switch type {
        case .Report:
            postObject["status"] = status.rawValue
        default:
            postObject["status"] = ""
        }
        postObject.saveEventually { (success, error) -> Void in
            if success {
                postObject.pinInBackgroundWithName(feedPinName, block: { (pinSuccess, error) -> Void in
                    if pinSuccess {
                        let post = CondoApiMapper.postFromPFObject(postObject, user: owner, community: community)
                        if let post = post {
                            completionBlock(post: post, error: nil)
                        }else{
                            completionBlock(post: nil, error: error)
                        }
                    }else{
                        completionBlock(post: nil, error: error)
                    }
                })
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
    
    public func createAnswer(owner: User, typeAnswer: PostQuestionAnswer.PostQuestionAnswerStatus, post: PostQuestion, completionBlock: (answer: PostQuestionAnswer?, error: NSError?) -> ()){
        
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
    
    public func getAllPostsAndAnswers(
        #user: User,
        community: Community,
        completionBlock: (
            posts: Array<Post>?,
            answers: Dictionary<String, PostQuestionAnswer.PostQuestionAnswerStatus>?,
            error: NSError?) -> ()){
        
        PFCloud.callFunctionInBackground("allPosts", withParameters: ["user": user.id, "community": community.id]) {
            (response: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                completionBlock(posts: nil, answers: nil, error: error)
            }else if let response = response as? Array<Dictionary<String, AnyObject>> {
                var posts = Array<Post>()
                var answers = Dictionary<String, PostQuestionAnswer.PostQuestionAnswerStatus>()
                for dictionary in response {
                    if let postObject = dictionary["post"] as? PFObject{
                        let post = CondoApiMapper.postFromPFObject(postObject, user: user, community: community)!
                        posts.append(post)
                        if let question = post as? PostQuestion,
                            answerString = dictionary["answer"] as? String, answer = PostQuestionAnswer.PostQuestionAnswerStatus(rawValue: answerString){
                            answers[question.id] = answer
                        }
                    }
                }
                completionBlock(posts: posts, answers: answers, error: nil)
            }else{
                assert(false, "\"getAllPostsAndAnswers\" received a malformed respose (\(response))")
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
