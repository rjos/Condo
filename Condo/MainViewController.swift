//
//  MainViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 17/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class MainViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.loggedIn() {
            self.performSegueWithIdentifier("loggedInSegue", sender: self)
        }else{
            self.performSegueWithIdentifier("logSegue", sender: self)
        }
    }
    
    func loggedIn() -> Bool {
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            return true
        } else {
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logSegue" {
            var vc = segue.destinationViewController as! LoginViewController
            vc.loginCallback = {
                (user) in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.performSegueWithIdentifier("loggedInSegue", sender: self)
                })
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
