//
//  TestExpenseParseViewController.swift
//  Condo
//
//  Created by Rodolfo José on 15/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class TestExpenseParseViewController: UIViewController {

    @IBOutlet weak var totalExpense: UITextField!
    @IBOutlet weak var expenseDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveExpense(sender: AnyObject) {
        
        let value: Double? = totalExpense.text.toDouble()
        
        if let value = value {
            ParseDatabase.sharedDatabase.createExpense(type:ExpenseType.Energy, date: expenseDate.date, totalExpense: value, community: Community(dictionary: ["id":"GpMV5wxc37", "name":"Ed. Santiago", "administratorID":"1234"]), completionBlock: { (expense, error) -> () in
                
                if let expense = expense {
                    println("Funfou")
                }else{
                    println(error)
                }
            })
        }
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
