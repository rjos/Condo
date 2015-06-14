//
//  CondoDatabase.swift
//  CondoModel
//
//  Created by Lucas Tenório on 13/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

public protocol CondoDatabase {
    func user() -> User
    func community(#id: String) ->Community
    func postListForCommunity(community: Community) -> ModelList
    func commentsForPost(post: Post) -> ModelList
    func answersForQuestion(question: PostQuestion) -> ModelList
    func expenseListForCommunity(community: Community) -> ModelList
}
