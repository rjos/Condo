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
    public var image:PFFile?
    override init(dictionary: Dictionary<String, AnyObject>) {
        self.name = dictionary["name"] as! String
        self.imageName = dictionary["imageName"] as! String
        
        if let imageData = (dictionary["image"] as? PFFile) {
            
            self.image = imageData
        }
        
        super.init(dictionary: dictionary)
    }
}
