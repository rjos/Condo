//
//  AddExpenseTableViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 16/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class AddExpenseTableViewController: UITableViewController {
    private var datePickerIndexPath: NSIndexPath? = nil
    private lazy var selectedDate: NSDate = NSDate()
    private var expenses = Dictionary<ExpenseType, NSNumber>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func dateChanged(sender: UIDatePicker) {
        self.selectedDate = sender.date
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
    }
    @IBAction func okButtonPressed(sender: AnyObject) {
        
        var newExpenses = Array<Dictionary<String, AnyObject>>()
        let db = ParseDatabase.sharedDatabase
        let community = db.testCommunity()
        for (type, totalExpense) in self.expenses {

            let dic = Expense.dictionary(type: type, date: self.selectedDate, totalExpense: totalExpense)
            newExpenses.append(dic)
        }
        db.createExpenses(expenses: newExpenses, community: community) { (expenses, error) -> () in
            if let e = expenses {
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                println("error uploading expenses \(error)")
            }
        }
        
        
    }
    
    private func datePickerIsShown() -> Bool {
        return self.datePickerIndexPath != nil
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.datePickerIsShown() {
                return 2
            }else{
                return 1
            }
        }else if section == 1 {
            return ExpenseType.allValues.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if self.datePickerIsShown() && indexPath == self.datePickerIndexPath {
                return self.getDatePickerCell(indexPath: indexPath)
            }else {
                return self.getDateCell(indexPath: indexPath)
            }
        }else{
            return self.getExpenseCell(indexPath: indexPath)
        }
    }

    func getDatePickerCell(#indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("datePickerCell", forIndexPath: indexPath) as! UITableViewCell
        return cell
    }
    
    func getDateCell(#indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dateCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(self.selectedDate.month)/\(self.selectedDate.year)"
        
        return cell
    }
    
    func getExpenseCell(#indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! UITableViewCell
        let type = ExpenseType.allValues[indexPath.row]
        let p = ExpenseDrawingProperties(type: type)
        cell.textLabel?.text = p.name
        if let number = self.expenses[type] {
            cell.detailTextLabel?.text =  "\(number)"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            if self.datePickerIsShown() {
                self.hideDatePicker()
            }else{
                self.showDatePicker()
            }
        } else if indexPath.section == 1 {
            self.presentExpenseDataAlert(indexPath)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let h = tableView.rowHeight
        if let dateIndex = self.datePickerIndexPath{
            if indexPath == dateIndex {
                return 250.0
            }
        }
        return h
    }
    
    //MARK: - Showing and Hiding Date Picker
    private let possibleDatePickerIndexPath = NSIndexPath(forRow: 1, inSection: 0)
    func hideDatePicker() {
        self.datePickerIndexPath = nil
        self.tableView.beginUpdates()
        self.tableView.deleteRowsAtIndexPaths([possibleDatePickerIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView.endUpdates()
        
    }
    
    func showDatePicker() {
        self.datePickerIndexPath = possibleDatePickerIndexPath
        self.tableView.beginUpdates()
        self.tableView.insertRowsAtIndexPaths([possibleDatePickerIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView.endUpdates()
        
    }
    
    //MARK: - Saving New Expense Data
    weak var saveAction: UIAlertAction? = nil

    func presentExpenseDataAlert(indexPath: NSIndexPath) {
        let type = ExpenseType.allValues[indexPath.row]
        let p = ExpenseDrawingProperties(type: type)
        let alert = UIAlertController(title: p.name, message: "Qual o valor desta despesa?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let t = UITextField()
        t.addTarget(self, action: Selector("textFieldDidChange:") , forControlEvents: UIControlEvents.ValueChanged)
        
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.placeholder = "R$ 0,00"
            textField.addTarget(self, action: Selector("textFieldDidChange:") , forControlEvents: UIControlEvents.EditingChanged)
        })
        
        let save = UIAlertAction(title: "Salvar", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as! UITextField
            let string: String = textField.text
            if let number = string.toDouble() {
                self.expenses[type] = number
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                self.navigationItem.rightBarButtonItem?.enabled = true
            }
            self.saveAction = nil
            //self.dismissViewControllerAnimated(true, completion: nil)
        })
        save.enabled = false
        self.saveAction = save
        
        alert.addAction(save)
        let a = UIAlertAction()
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            self.saveAction = nil
            //self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        self.presentViewController(alert, animated: true) {
            
        }
    }
    func textFieldDidChange(textField: UITextField) {
        if let save = self.saveAction {
            if let number = textField.text.toDouble() {
                save.enabled = true
            }else{
                save.enabled = false
            }
        }
    }
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
