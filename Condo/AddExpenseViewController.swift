//
//  AddExpenseViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 21/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class AddExpenseViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var type = ExpenseType.Energy {
        didSet{
            let properties = ExpenseDrawingProperties(type: self.type)
            self.title = properties.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.enabled = false
        self.textField.placeholder = "R$ 0,00"
        self.textField.addTarget(self, action: Selector("textFieldDidChange:") , forControlEvents: UIControlEvents.EditingChanged)
        self.textField.becomeFirstResponder()
        
        let date = NSDate()
        self.datePicker.maximumDate = date
        self.datePicker.minimumDate = date.lastyear
        
    }
    override func viewWillAppear(animated: Bool) {
        let properties = ExpenseDrawingProperties(type: self.type)
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = properties.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func textFieldDidChange(textField: UITextField) {
        if let save = self.saveButton {
            if let number = textField.text.toDouble() {
                save.enabled = true
            }else{
                save.enabled = false
            }
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.textField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        ExpensesController.sharedController.addExpense(type: self.type, totalExpense: self.textField.text.toDouble()!, date: self.datePicker.date)
        self.textField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
