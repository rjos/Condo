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
    public let administrator: User
    public override init(dictionary: Dictionary<String, AnyObject>) {
        self.name = dictionary["name"] as! String
        self.administrator = dictionary["administrators"] as! User
        super.init(dictionary: dictionary)
    }
}
