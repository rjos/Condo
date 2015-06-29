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
    
    var type: PostContentType? = nil
    
    func setupWithType() {
        if let t = self.type {
            let p = PostDrawingProperties(type: t)
            self.contentView.layer.cornerRadius = p.cornerRadius
            self.view.tintColor = p.outlineColor
            self.textReport.layer.cornerRadius = p.cornerRadius
            self.textReport.layer.borderWidth = p.lineWidth
            self.textReport.layer.borderColor = p.outlineColor.CGColor
            self.textReport.tintColor = p.outlineColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnPublish.enabled = false
        self.textReport.delegate = self
        
        self.pickerTypeUser = UIPickerView()
        self.pickerTypeUser.delegate = self
        

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
        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardWillHideNotification, object: nil)
        //self.type = PostContentType.Report
        self.setupWithType()
        self.textReport.becomeFirstResponder()
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
        self.contentView.transform = CGAffineTransformMakeScale(0.4, 0.4)
        UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { () -> Void in
                self.contentView.transform = CGAffineTransformIdentity
            })
        }) { (completed) -> Void in
            
        }
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
        
        if countText > 0 && countText <= 500 {
            self.btnPublish.enabled = true
        }else{
            self.btnPublish.enabled = false
        }
        let characters = 500 - countText
        self.countLetter.text = "Max: \(characters)"
        self.countLetter.textColor =  self.btnPublish.enabled ? UIColor.lightGrayColor() : UIColor.redColor()
    }
    
    @IBAction func ShowBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func ShowPublish(sender: AnyObject) {
        let text = self.textReport.text
        FeedController.sharedController.createPost(text: text, type: self.type!)
        self.contentView.transform = CGAffineTransformIdentity
        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5){
                self.contentView.transform = CGAffineTransformMakeScale(0.4, 0.4)
            }
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5){
                self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0.0, -self.view.frame.size.width)
            }
            
            })
            { (completed) -> Void in
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
