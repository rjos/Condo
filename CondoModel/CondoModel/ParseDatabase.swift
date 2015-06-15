//
//  ParseDatabase.swift
//  CondoModel
//
//  Created by Rodolfo José on 15/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import Parse
import Bolts

public class ParseDatabase: NSObject {
   
    static let shareInstance = ParseDatabase()
    
    public func setup(){
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("frhoWZOYHwsv5M6bTlBgbnsKb4MteIZle69dovkh",
            clientKey: "EC0xXL6isxFFX64o8sDFREmRHZ6nBe0kJlZ76Al2")
    }
    
    public func createCommunity(name: String){
        
        let testObject = PFObject(className: "Community")
        testObject["name"] = name
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if success {
                println("Sucesso")
            }else{
                println("Deu erro")
            }
        }
    }
}
