//
//  User.swift
//  CondoModel
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

public class User: Model {
    public let name: String
    //MARK: Tem que remover depois do dummy
    public let imageName: String
    override init(dictionary: Dictionary<String, AnyObject>) {
        self.name = dictionary["name"] as! String
        self.imageName = dictionary["imageName"] as! String
        super.init(dictionary: dictionary)
    }
}
