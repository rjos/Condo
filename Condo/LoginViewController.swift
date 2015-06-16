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
    
    @IBOutlet var login:UITextField!
    @IBOutlet var password:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var loginCallback: (PFUser?, NSError?) -> () = {
        (user, error) in
        //nothing
    }
    
    @IBAction func login(sender: UIButton) {
        
        var loginaux:NSString
        var passwordaux:NSString
        
        loginaux = login.text!
        passwordaux = password.text!
        
        PFUser.logInWithUsernameInBackground(loginaux as String, password:passwordaux as String) {
            (user: PFUser?, error: NSError?) -> Void in
            self.loginCallback(user, error)
        }
    }

}
