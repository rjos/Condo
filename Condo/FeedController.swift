//
//  FeedController.swift
//  Condo
//
//  Created by Lucas Tenório on 28/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

typealias AnswerStatus = PostQuestionAnswer.PostQuestionAnswerStatus
class FeedController: NSObject {
    static let sharedController =  FeedController()
    
    
    
    private var _posts = Array<Post>()
    private var _answers = Dictionary<String, AnswerStatus>()
    private var _hasData = false
    
    
    
    var hasData: Bool {
        get {
            return self._hasData
        }
    }
    var posts: Array<Post> {
        get {
            return self._posts
        }
    }
    
    func setAnswerStatus(#question: PostQuestion, status: AnswerStatus) {
        self._answers[question.id] = status
        let user = ParseDatabase.sharedDatabase.getCurrentUser()
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        ParseDatabase.sharedDatabase.createAnswer(user, typeAnswer: status, post: question) { (answer, error) -> () in
            if let error = error {
                
            }else{
                self.postNotificationNewAnswer()
            }
        }
    }
    
    func getAnswerStatus(#question: PostQuestion) -> AnswerStatus{
        if let status = self._answers[question.id] {
            return status
        }else{
            return PostQuestionAnswer.PostQuestionAnswerStatus.NoAnswer
        }
    }
    
    func reloadData() {
        self._hasData = false
        self._answers = Dictionary<String, AnswerStatus>()
        self._posts = Array<Post>()
        
        let user = ParseDatabase.sharedDatabase.getCurrentUser()
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        ParseDatabase.sharedDatabase.getAllPostsAndAnswers(user: user, community: community) { (posts, answers, error) -> () in
            if let error = error {
                self.postNotificationErrorFetching(error)
            }else if let answers = answers, posts = posts{
                self._answers = answers
                self._posts = posts
                self._hasData = true
                self.postNotificationNewData()
            }
        }
    }
    
    //MARK: Notifications
    static let NotificationNewData = "CondoFeedNotificationNewData"
    static let NotificationFetchError = "CondoFeedNotificationFetchError"
    static let NotificationNewAnswer = "CondoFeedNotificationNewAnswer"
    static let NotificationNewPost = "CondoFeedNotificationNewPost"
    static let NotificationNewComment = "CondoFeedNotificationNewComment"
    
    private func postNotificationNewAnswer() {
        NSNotificationCenter.defaultCenter().postNotificationName(FeedController.NotificationNewAnswer, object: self, userInfo: nil)
    }
    private func postNotificationNewPost() {
        NSNotificationCenter.defaultCenter().postNotificationName(FeedController.NotificationNewPost, object: self, userInfo: nil)
    }
    private func postNotificationNewComment() {
        NSNotificationCenter.defaultCenter().postNotificationName(FeedController.NotificationNewComment, object: self, userInfo: nil)
    }
    private func postNotificationNewData() {
        NSNotificationCenter.defaultCenter().postNotificationName(FeedController.NotificationNewData, object: self, userInfo: nil)
    }
    private func postNotificationErrorFetching(error: NSError) {
        NSNotificationCenter.defaultCenter().postNotificationName(FeedController.NotificationFetchError, object: self, userInfo: nil)
    }
}
