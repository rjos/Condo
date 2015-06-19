//
//  NewPostViewController.swift
//  Condo
//
//  Created by Rodolfo José on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
import ParseUI

class NewPostViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UITextViewDelegate{

    @IBOutlet weak var countLetter: UILabel!
    @IBOutlet weak var textReport: UITextView!
    @IBOutlet weak var btnPublish: UIButton!
    @IBOutlet weak var bottomConstraintTextView: NSLayoutConstraint!
    
    @IBOutlet weak var contentView: UIView!
    var pickerTypeUser : UIPickerView!
    var toolBar : UIToolbar!
    var imgProfile : PFImageView!
    
    var typesUserArray = ["Síndico", "Público"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = UIColor.condoReportBackgroundColor()
        self.contentView.layer.cornerRadius = 15.0
        
        self.btnPublish.enabled = false
        
        //self.typeUser.delegate = self
        self.textReport.delegate = self
        
        self.pickerTypeUser = UIPickerView()
        self.pickerTypeUser.delegate = self
        
        //self.typeUser.inputView = pickerTypeUser
        
//        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
//        self.toolBar.barStyle = UIBarStyle.Default
//        
//        let btnDone : UIBarButtonItem! = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("SelectedItemPickerView"))
//        let btnCancel : UIBarButtonItem! = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("CancelItemPickerView"))
//        
//        self.toolBar.setItems([btnCancel, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil) , btnDone], animated: true)
        
        //self.typeUser.inputAccessoryView = self.toolBar
        let imageRect = CGRect(x: 4, y: 4, width: 40, height: 40)
        self.imgProfile = PFImageView(frame: imageRect)
        self.imgProfile.layer.cornerRadius = self.imgProfile.bounds.width / 2
        self.imgProfile.clipsToBounds = true
        
        let user = ParseDatabase.sharedDatabase.getCurrentUser()
        
        if let image = user.image {
            
            self.imgProfile.file = image
            self.imgProfile.loadInBackground()
        }else{
            self.imgProfile.image = UIImage(named: user.imageName)
        }
        
        var bezierPath : UIBezierPath = UIBezierPath(rect: imageRect)
        
        self.textReport.textContainer.exclusionPaths = [bezierPath]
        self.textReport.addSubview(self.imgProfile)
        
        self.textReport.layer.cornerRadius = 15.0
        self.textReport.layer.borderWidth = 2.0
        self.textReport.layer.borderColor = UIColor.condoReportBackgroundColor().CGColor
        self.textReport.tintColor = UIColor.condoReportBackgroundColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardWillHideNotification, object: nil)
        self.textReport.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardDidShow (notification: NSNotification){
        
        let info = (notification.userInfo as! Dictionary<NSString, AnyObject>)
        let valueSize = info["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let rect = valueSize.CGRectValue()
        let size = rect.size
        
        self.bottomConstraintTextView.constant = 32.0 + size.height
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func keyboardDidHide(notification: NSNotification){
        let info = (notification.userInfo as! Dictionary<NSString, AnyObject>)
        let valueSize = info["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let rect = valueSize.CGRectValue()
        let size = rect.size
        
        self.bottomConstraintTextView.constant = 32.0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func textViewDidChange(textView: UITextView) {
        let textPost = self.textReport.text
        let countText = count(textPost)
        
        if countText <= 500 {
            if countText > 0 {
                self.btnPublish.enabled = true
            }else{
                self.btnPublish.enabled = false
            }
            
            let characters = 500 - countText
            self.countLetter.text = "Max: \(characters)"
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.typesUserArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.typesUserArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.typeUser.text = self.typesUserArray[row]
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
//        self.typeUser.resignFirstResponder()
//        self.textReport.resignFirstResponder()
    }
    
    @IBAction func ShowBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    @IBAction func ShowPublish(sender: AnyObject) {
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        let user = ParseDatabase.sharedDatabase.getCurrentUser()
        let text = self.textReport.text
        
        ParseDatabase.sharedDatabase.createPost(type: PostContentType.Report, owner: user, text: text, status: PostReport.PostReportStatus.Open, community: community) { (post, error) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func SelectedItemPickerView(){
        //self.typeUser.resignFirstResponder()
    }
    
    func CancelItemPickerView(){
        //self.typeUser.resignFirstResponder()
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
