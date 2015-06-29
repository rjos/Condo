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
    @IBOutlet var headerVector:VectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 10
        loginbutton.backgroundColor = UIColor.condoBlue()
        headerVector.drawSVGWithName("logo")
        headerVector.strokeColor = UIColor.condoBlue()
        headerVector.fillColor = UIColor.condoBlue60()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        if let user = PFUser.currentUser(){
            self.loginCallback(user)
        }else{
            headerVector.animateShape()
        }
        
    }
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
                var alert = UIAlertController(title: "Tente Novamente", message: "Email e/ou Senha Incorretos", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    switch action.style{
                    case .Default:
                        println("default")
                        
                    case .Cancel:
                        println("cancel")
                        
                    case .Destructive:
                        println("destructive")
                    }
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func displayAlertWithLoginError(error: NSError?) {
        //dasd
    }
 
}
