//
//  NewPostViewController.swift
//  Condo
//
//  Created by Rodolfo José on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UITextViewDelegate{

    @IBOutlet weak var typeUser: UITextField!
    @IBOutlet weak var countLetter: UILabel!
    @IBOutlet weak var textReport: UITextView!
    @IBOutlet weak var btnPublish: UIButton!
    
    var pickerTypeUser : UIPickerView!
    var toolBar : UIToolbar!
    var imgProfile : UIImageView!
    
    var typesUserArray = ["Síndico", "Público"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnPublish.enabled = false
        
        self.pickerTypeUser = UIPickerView()
        self.pickerTypeUser.delegate = self
        
        self.typeUser.inputView = pickerTypeUser
        
        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        self.toolBar.barStyle = UIBarStyle.Default
        
        let btnDone : UIBarButtonItem! = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("SelectedItemPickerView"))
        let btnCancel : UIBarButtonItem! = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("CancelItemPickerView"))
        
        self.toolBar.setItems([btnCancel, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil) , btnDone], animated: true)
        
        self.typeUser.inputAccessoryView = self.toolBar
        
        self.imgProfile = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        self.imgProfile.layer.cornerRadius = self.imgProfile.bounds.width / 2
        self.imgProfile.clipsToBounds = true
        
        self.imgProfile.image = UIImage(named: "pedro")
        
        var bezierPath : UIBezierPath = UIBezierPath(rect: CGRect(x: self.imgProfile.bounds.origin.x, y: self.imgProfile.bounds.origin.y, width: self.imgProfile.bounds.width, height: self.imgProfile.bounds.height))
        
        self.textReport.textContainer.exclusionPaths = [bezierPath]
        self.textReport.addSubview(self.imgProfile)
        
        self.textReport.layer.borderWidth = 1.0
        self.textReport.layer.borderColor = UIColor.blueColor().CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return false
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
        self.typeUser.text = self.typesUserArray[row]
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.typeUser.resignFirstResponder()
        self.textReport.resignFirstResponder()
    }
    
    @IBAction func ShowBack(sender: AnyObject) {
    }

    @IBAction func ShowPublish(sender: AnyObject) {
        
    }
    
    func SelectedItemPickerView(){
        self.typeUser.resignFirstResponder()
    }
    
    func CancelItemPickerView(){
        self.typeUser.resignFirstResponder()
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
