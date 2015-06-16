//
//  LoginViewController.swift
//  Condo
//
//  Created by eduardo leite soares neto on 6/16/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class LoginViewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cadastro()
    }
    
    func cadastro()
    {
        var user = PFUser()
        user.username = "1"
        user.password = "1"
        user.email = "email@example.com"
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                NSLog("jafoi")
            } else {
                // Hooray! Let them use the app now.
            }
        }
    }
    @IBAction func login(sender: UIButton) {
        PFUser.logInWithUsernameInBackground("1", password:"1") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                NSLog("hu3")
            } else {
                // The login failed. Check error to see why.
            }
        }
    }

}
