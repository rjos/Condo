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
    public let administratorID: String
    public override init(dictionary: Dictionary<String, AnyObject>) {
        self.name = dictionary["name"] as! String
        self.administratorID = dictionary["administratorID"] as! String
        super.init(dictionary: dictionary)
    }
}
