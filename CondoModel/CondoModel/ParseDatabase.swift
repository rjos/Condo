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
   
    public static let sharedDatabase = ParseDatabase()
    
    public func setup(){
        
        Parse.enableLocalDatastore()
        //PFObject.unpinAllObjectsInBackground()
        // Initialize Parse.
        Parse.setApplicationId("frhoWZOYHwsv5M6bTlBgbnsKb4MteIZle69dovkh",
            clientKey: "EC0xXL6isxFFX64o8sDFREmRHZ6nBe0kJlZ76Al2")
    }
    
    public func createCommunity(name: String, administrators: User ,completionBlock: (community: Community?, error: NSError?) -> ()){
        
        let testObject = PFObject(className: "Community")
        testObject["name"] = name
        testObject["administrators"] = PFObject(withoutDataWithClassName: "_User", objectId: administrators.id)
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println(testObject.objectId)
            if success {
                
                let community = CondoApiMapper.communityFromPFObject(testObject)
                
                if let community = community {
                    completionBlock(community: community, error: error)
                }else{
                    completionBlock(community: nil, error: error)
                }
            }else{
                completionBlock(community: nil, error: error)
            }
        }
    }
    
    public func getCommunityUser()->Community {
        
        /*let user = self.getCurrentUser()
        
        return user.community*/
        
        return Community(dictionary: ["id":"GpMV5wxc37", "name":"Ed. Santiago", "administrators": self.getCurrentUser()])
    }
    
    public func getCurrentUser() -> User {
        return CondoApiMapper.userFromPFObject(PFUser.currentUser()!)!
    }
    
//    public func getPostTest(user: User, community: Community) -> Post {
//        return PostReport(dictionary: [
//            "id": "pLH3l1Fcmb",
//            "owner": user,
//            "community": community,
//            "text": "teste 1",
//            "status":"PostReportStatusOpen",
//            "type": "PostContentTypeReport",
//            "totalComments": 1
//            ])
//    }
    
    
}
