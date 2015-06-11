//
//  Community.swift
//  CondoModel
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

public class Community: Model {
    public let name: String
    public let administrators: ModelList
    public let posts: ModelList
    public let expenses: ModelList
    public override init(dictionary: Dictionary<String, AnyObject>) {
        self.name = dictionary["name"] as! String
        self.administrators = dictionary["administrators"] as! ModelList
        self.expenses = dictionary["expenses"] as! ModelList
        self.posts = dictionary["posts"] as! ModelList
        super.init(dictionary: dictionary)
    }
}
