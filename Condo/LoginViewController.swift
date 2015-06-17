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
    @IBOutlet var loginbutton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 10
        loginbutton.backgroundColor = UIColor.condoBlue()
        
    }
    
    var loginCallback: (PFUser) -> () = {
        (user) in
        //nothing

        
    }
    
    @IBAction func login(sender: UIButton) {
        
        var loginaux:NSString
        var passwordaux:NSString
        
        loginaux = login.text!
        passwordaux = password.text!
        
        PFUser.logInWithUsernameInBackground(loginaux as String, password:passwordaux as String) {
            (user: PFUser?, error: NSError?) -> Void in
            if let processedUser = user {
                // Do stuff after successful login.
                self.loginCallback(processedUser)
                
            } else {
                self.displayAlertWithLoginError(error)
                // The login failed. Check error to see why.
            }
            
        }
    }
    
    func displayAlertWithLoginError(error: NSError?) {
        //dasd
    }
 
}
