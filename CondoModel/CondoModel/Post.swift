//
//  Post.swift
//  CondoModel
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

public enum PostContentType: String {
    case Question = "PostContentTypeQuestion"
    case Report = "PostContentTypeReport"
    case Announcement = "PostContentTypeAnnouncement"
}

public class Post: Model {
    public let owner: User
    public let type: PostContentType
    public let text: String
    public let comments: ModelList
    public override init(dictionary: Dictionary<String, AnyObject>) {
        self.owner = dictionary["owner"] as! User
        self.text = dictionary["text"] as! String
        self.type = PostContentType(rawValue: dictionary["type"] as! String)!
        self.comments = dictionary["comments"] as! ModelList
        super.init(dictionary: dictionary)
    }
}

public class PostAnnouncement: Post{
    public override init(var dictionary: Dictionary<String, AnyObject>) {
        dictionary["type"] = PostContentType.Announcement.rawValue
        super.init(dictionary: dictionary)
    }
}

public class PostReport: Post {
    public enum PostReportStatus: String {
        case Open = "PostReportStatusOpen"
        case Close = "PostReportStatusClosed"
    }
    public let status: PostReportStatus
    public override init(var dictionary: Dictionary<String, AnyObject>) {
        self.status = PostReportStatus(rawValue: dictionary["status"] as! String)!
        dictionary["type"] = PostContentType.Report.rawValue
        super.init(dictionary: dictionary)
    }
}

public class PostQuestion: Post {
    public let answers: ModelList
    public override init(var dictionary: Dictionary<String, AnyObject>) {
        self.answers = dictionary["answers"] as! ModelList
        dictionary["type"] = PostContentType.Question.rawValue
        super.init(dictionary: dictionary)
    }
}

public class PostQuestionAnswer: Model {
    public enum PostQuestionAnswerStatus: String {
        case NoAnswer = "PostQuestionAnswerNoAnswer"
        case Agree = "PostQuestionAnswerAgree"
        case Disagree = "PostQuestionAnswerDisagree"
    }
    public let owner: User
    public let status: PostQuestionAnswerStatus
    public override init(dictionary: Dictionary<String, AnyObject>) {
        self.status = PostQuestionAnswerStatus(rawValue: dictionary["status"] as! String)!
        self.owner = dictionary["owner"] as! User
        super.init(dictionary: dictionary)
    }
}


