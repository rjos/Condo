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
    public let email: String
    public var apt: String?
    public var image:PFFile?
    public var community: Community?
    override init(dictionary: Dictionary<String, AnyObject>) {
        self.name = dictionary["name"] as! String
        self.imageName = dictionary["imageName"] as! String
        self.email = dictionary["email"] as! String
        
        if let apt = dictionary["apt"] as? String {
            self.apt = apt
        }else{
            self.apt = nil
        }
        
        if let community = dictionary["community"] as? Community {
            self.community = community
        }
        
        if let imageData = (dictionary["image"] as? PFFile) {
            
            self.image = imageData
        }
        
        super.init(dictionary: dictionary)
    }
}
