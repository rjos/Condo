//
//  DetailsExpensesTableViewCell.swift
//  Condo
//
//  Created by Rodolfo José on 19/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class DetailsExpensesTableViewCell: UITableViewCell {

    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var dateExpense: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        // Initialization code
    }

    var expense: Expense? = nil{
        didSet{
            if let expense = expense {
                
                let properties = ExpenseDrawingProperties(type: expense.type)
                
                self.dateExpense.text = "\(expense.expenseDate.day)/\(expense.expenseDate.month)/\(expense.expenseDate.year)"
                self.totalExpense.text = "R$ \(expense.totalExpense)"
            }
        }
    }
    
    var type: ExpenseType? {
        didSet {
            if let type = type {
                
                let properties = ExpenseDrawingProperties(type: type)
                
                self.dateExpense.textColor = properties.selectedBackgroundColor
                self.totalExpense.textColor = properties.selectedBackgroundColor
            }
        }
    }
    
    //override func setSelected(selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    //}
    
}
