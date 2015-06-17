//
//  Comment.swift
//  CondoModel
//
//  Created by Rodolfo José on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

public class Comment: Model {
   
    public let owner : User
    public let text  : String
    public let post  : Post
    override init(dictionary: Dictionary<String, AnyObject>) {
        self.owner = dictionary["owner"] as! User
        self.text  = dictionary["text"]  as! String
        self.post  = dictionary["post"]  as! Post
        super.init(dictionary: dictionary)
    }
}
