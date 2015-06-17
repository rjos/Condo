//
//  SignUpViewController.swift
//  Condo
//
//  Created by eduardo leite soares neto on 6/16/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//


import UIKit
import CondoModel

class SignUpViewController:UIViewController{
    
    @IBOutlet var nome:UITextField!
    @IBOutlet var email:UITextField!
    @IBOutlet var senha:UITextField!
    @IBOutlet var cadastro:UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()
        cadastro.layer.cornerRadius = 10
    }
    @IBAction func cadastro(sender: UIButton)
    {
        
        var user = PFUser()
        user.username = email.text
        user.password = senha.text
        
        // other fields can be set just like with PFObject
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                self.displayAlertWithLoginError(error)
                // Show the errorString somewhere and let the user try again.
                
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func displayAlertWithLoginError(error: NSError?) {
        
    }
    
}


