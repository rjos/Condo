//
//  ListDetailsExpensesTableViewController.swift
//  Condo
//
//  Created by Rodolfo José on 18/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class ListDetailsExpensesTableViewController: UITableViewController {

    private let controller = ExpensesController.sharedController
    var type: ExpenseType?
    var database : Array<Expense> = []
    
    var expenses =  Array<Array<Expense>>()
    
    var group : Dictionary<String, Array<Expense>> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var expenses = controller.getAllExpenses(type: self.type!)
        var e: Expense? = nil
        
        
        expenses.sort { (a, b) -> Bool in
            let firstDate = a.expenseDate
            let secondDate = b.expenseDate
            if firstDate.compare(secondDate) != NSComparisonResult.OrderedAscending {
                return true
            }
            return false
        }
        
        self.database = expenses
        
        for expense in self.database {
            
            let expenseListOptional = self.group["\(expense.expenseDate.month)-\(expense.expenseDate.year)"]
            
            var expenseList: Array<Expense>
            
            if let group = expenseListOptional {
                expenseList = group
            }else{
                expenseList = Array<Expense>()
            }
            
            expenseList.append(expense)
            
            self.group["\(expense.expenseDate.month)-\(expense.expenseDate.year)"] = expenseList
        }
        
        for (key, value) in  self.group {
            self.expenses.append(value)
        }
        
        self.expenses.sort { (arrayA, arrayB) -> Bool in
            let first: Array<Expense> = arrayA
            let second: Array<Expense>= arrayB
            if first.first!.expenseDate.compare(second.first!.expenseDate) == NSComparisonResult.OrderedAscending {
                return false
            }
            return true
        }
        println(self.expenses)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.expenses.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.expenses[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! UITableViewCell
        let expense = self.expenses[indexPath.section][indexPath.row]
        cell.textLabel?.text = "\(expense.expenseDate)"
        // Configure the cell...
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

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
