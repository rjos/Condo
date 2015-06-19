//
//  CreateCondoViewController.swift
//  Condo
//
//  Created by Rodolfo José on 19/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class CreateCondoViewController: UIViewController {

    @IBOutlet weak var nameCondo: UITextField!
    @IBOutlet weak var countApt: UITextField!
    @IBOutlet weak var addressCondo: UITextField!
    @IBOutlet weak var numberCondo: UITextField!
    @IBOutlet weak var cepCondo: UITextField!
    @IBOutlet weak var cityCondo: UITextField!
    @IBOutlet weak var stateCondo: UITextField!
    
    @IBOutlet weak var cityConstraint: NSLayoutConstraint!
    @IBOutlet weak var stateConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor.condoBlue80()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.nameCondo.layer.borderWidth = 1.0
        self.nameCondo.layer.cornerRadius = 5.0
        self.nameCondo.layer.borderColor = UIColor.condoBlue80().CGColor
        self.nameCondo.attributedPlaceholder = NSAttributedString(string: self.nameCondo.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue80()])

        self.countApt.attributedPlaceholder = NSAttributedString(string: self.countApt.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue60()])
        
        self.addressCondo.attributedPlaceholder = NSAttributedString(string: self.addressCondo.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue60()])
        
        self.numberCondo.attributedPlaceholder = NSAttributedString(string: self.numberCondo.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue60()])
        
        self.cepCondo.attributedPlaceholder = NSAttributedString(string: self.cepCondo.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue60()])
        
        self.cityCondo.attributedPlaceholder = NSAttributedString(string: self.cityCondo.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue60()])
        
        self.stateCondo.attributedPlaceholder = NSAttributedString(string: self.stateCondo.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.condoBlue60()])
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardHide(notification: NSNotification){
        
        let info = (notification.userInfo as! Dictionary<NSString, AnyObject>)
        let valueSize = info["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let rect = valueSize.CGRectValue()
        let size = rect.size
        
        self.cityConstraint.constant = 180.0
        self.stateConstraint.constant = 180.0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })

    }
    
    func keyboardShow(notification: NSNotification){
        
        let info = (notification.userInfo as! Dictionary<NSString, AnyObject>)
        let valueSize = info["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let rect = valueSize.CGRectValue()
        let size = rect.size
        
        self.cityConstraint.constant = 32.0 + size.height
        self.stateConstraint.constant = 32.0 + size.height
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.nameCondo.resignFirstResponder()
        self.countApt.resignFirstResponder()
        self.addressCondo.resignFirstResponder()
        self.numberCondo.resignFirstResponder()
        self.cepCondo.resignFirstResponder()
        self.cityCondo.resignFirstResponder()
        self.stateCondo.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
