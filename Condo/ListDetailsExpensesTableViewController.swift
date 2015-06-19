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
    
    var database : Array<Array<Expense>> = []
    var keys: Array<String> = []
    
    var type: ExpenseType? {
        didSet{
            if let type = type {
                
                let properties = ExpenseDrawingProperties(type: type)
                
                self.title = properties.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerNib((UINib(nibName: "DetailsExpensesTableViewCell", bundle: NSBundle.mainBundle())), forCellReuseIdentifier: "DetailsExpenses")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.reloadData()
        
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

    override func viewWillAppear(animated: Bool) {
        let properties = ExpenseDrawingProperties(type: self.type!)
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = properties.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailsExpenses", forIndexPath: indexPath) as! DetailsExpensesTableViewCell
        
        let expense = self.database[indexPath.section][indexPath.row]
        
        cell.expense = expense
        
        //cell.textLabel?.text = "\(expense.expenseDate)"
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let dateArr = split(self.keys[section]) {$0 == "-"}
        
        var monthToInt = dateArr[0].toInt()
        let year  = dateArr[1]
        
        let month = self.month(monthToInt!)
        
        return "\(month) - \(year)"
    }
    
    func month(int: Int) -> String{
        
        switch int {
        case 1: return "Janeiro"
        case 2: return "Fevereiro"
        case 3: return "Março"
        case 4: return "Abril"
        case 5: return "Maio"
        case 6: return "Junho"
        case 7: return "Julho"
        case 8: return "Agosto"
        case 9: return "Setembro"
        case 10: return "Outubro"
        case 11: return "Novembro"
        case 12: return "Dezembro"
        default: return ""
        }
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
