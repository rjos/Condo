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
    private let notificationManager = NotificationManager()
    var database : Array<Array<Expense>> = []
    //var keys: Array<String> = []
    
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
        self.processEspenses()
        self.tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.registerNib((UINib(nibName: "DetailsExpensesTableViewCell", bundle: NSBundle.mainBundle())), forCellReuseIdentifier: "DetailsExpenses")
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 50.0
        self.tableView.reloadData()
        self.notificationManager.registerObserver(ExpensesController.ExpenseAddedNotification) {
            (notification) in
            println("received notification")
            self.processEspenses()
            self.tableView.reloadData()
        }
    }
    
    private func processEspenses() {
        self.database = []
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

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return self.database.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.database[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailsExpenses", forIndexPath: indexPath) as! DetailsExpensesTableViewCell
        
        let expense = self.database[indexPath.section][indexPath.row]
        
        cell.expense = expense
        cell.type = expense.type
        //cell.textLabel?.text = "\(expense.expenseDate)"
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let first = self.database[section].first {
            return "\(self.month(first.expenseDate.month)) - \(first.expenseDate.year)"
        }
        return nil
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
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if self.database[indexPath.section].count == 1 {
                self.deleteExpenseAtIndexPath(indexPath)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.database.removeAtIndex(indexPath.section)
                tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
                
            }else{
                self.deleteExpenseAtIndexPath(indexPath)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        }
    }
    func deleteExpenseAtIndexPath(indexPath: NSIndexPath) {
        let expenseID = self.database[indexPath.section][indexPath.row].id
        self.database[indexPath.section].removeAtIndex(indexPath.row)
        ExpensesController.sharedController.deleteExpense(id: expenseID)
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addExpenseSegue" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let vc = nav.topViewController as? AddExpenseViewController {
                    vc.type = self.type!
                }
            }
        }
    }


}
