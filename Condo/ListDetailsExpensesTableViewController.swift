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
    
    var database : Array<Array<Expense>> = []
    var keys: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var expenses = controller.getAllExpenses(type: self.type!)
        
        expenses.sort { (a, b) -> Bool in
            let firstDate = a.expenseDate
            let secondDate = b.expenseDate
            if firstDate.compare(secondDate) != NSComparisonResult.OrderedAscending {
                return true
            }
            return false
        }
        
        var key: String = ""
        var index: Int = -1
        
        for expense in (expenses as Array<Expense>) {
            
            var currentKey = "\(expense.expenseDate.month)-\(expense.expenseDate.year)"
            
            if key != currentKey {
                
                self.keys.append(currentKey)
                key = currentKey
                
                index += 1
                self.database.append(Array<Expense>())

            }
            
            self.database[index].append(expense)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.database[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("expenseCell", forIndexPath: indexPath) as! UITableViewCell
        let expense = self.database[indexPath.section][indexPath.row]
        cell.textLabel?.text = "\(expense.expenseDate)"
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.keys[section]
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
