//
//  Model.swift
//  CondoModel
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit


public class Model: NSObject {
    public let id: String
    let internalDictionary: Dictionary<String, AnyObject>
    
    public init(dictionary: Dictionary <String, AnyObject>) {
        self.internalDictionary = dictionary
        self.id = dictionary["id"] as! String
    }
}

public protocol ModelList {
    func count() -> Int
    func hasMoreData() -> Bool
    func modelAtIndex(index: Int)-> Model
    func fetchMoreData()
    var dataFetchedCallback: (newData: Bool, error: NSError?) -> (){get set}
}



