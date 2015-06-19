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
    @IBOutlet var headerVector2:VectorView!



    override func viewDidLoad() {
        super.viewDidLoad()
        cadastro.layer.cornerRadius = 10
        headerVector2.drawSVGWithName("logo")
        headerVector2.fillColor = UIColor.condoBlue60()
        headerVector2.strokeColor = UIColor.condoBlue()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func cadastro(sender: UIButton)
    {
        
        var user = PFUser()
        user.username = email.text
        user.password = senha.text
        user["fullname"] = nome.text
        
        // other fields can be set just like with PFObject
        if (nome.text == "" || email.text == "" || senha.text == ""){
        }
        else{
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                self.displayAlertWithLoginError(error)
                // Show the errorString somewhere and let the user try again.
                var alert = UIAlertController(title: "Tente Novamente", message: "Email já cadastrado", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func displayAlertWithLoginError(error: NSError?) {
        
    }
    
}


