//
//  ExpenseGraphViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 14/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class ExpenseGraphViewController: UIViewController, JBBarChartViewDataSource, JBBarChartViewDelegate {
    @IBOutlet weak var expenseNameLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var barChartView: JBBarChartView!
    
    let evenSelectionColor = UIColor(white: 1.0, alpha: 0.8)
    let oddSelectionColor = UIColor(white: 1.0, alpha: 0.5)
    
    let currentDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.barChartView.delegate = self
        self.barChartView.dataSource = self
        
        self.barChartView.reloadData()
        self.detailLabel.hidden = true
        // Do any additional setup after loading the view.
    }
    
    var expenses: Array<Expense> = [] {
        didSet{
            expenses.sort { (a, b) -> Bool in
                let firstDate = a.expenseDate
                let secondDate = b.expenseDate
                if firstDate.compare(secondDate) == NSComparisonResult.OrderedDescending {
                    return false
                }
                return true
            }
        }
    }
    
    var animating: Bool = false
    var selectedType = ExpenseType.allValues[0] {
        didSet{
            var p = ExpenseDrawingProperties(type: self.selectedType)
            self.view.backgroundColor = p.selectedBackgroundColor
            self.barChartView.backgroundColor = p.selectedBackgroundColor
            self.expenseNameLabel.text = p.name
            if self.animating {
                self.barChartView.reloadData()
            }else {
                self.animating = true
                self.barChartView.setState(JBChartViewState.Collapsed, animated: false) { () -> Void in
                    self.barChartView.reloadData()
                    self.barChartView.setState(JBChartViewState.Expanded, animated: true) { () -> Void in
                        self.animating = false
                    }
                }
            }
        }
    }
    
    var selectedTypeProperties: ExpenseDrawingProperties {
        get{
            return ExpenseDrawingProperties(type: self.selectedType)
        }
    }
    
    //MARK: BarChartView Data Source
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return 12//UInt(self.expenses.count)
    }
    
    
    
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt, touchPoint: CGPoint) {
        
        let month = self.month(Int(index + 1))
        let expenseTotal = self.getTotalExpenseForMonthIndex(Int(index))
        self.detailLabel.hidden = false
        if expenseTotal <= 0.00001 {
            self.detailLabel.text = "\(month): Sem dados"
        }else{
            self.detailLabel.text = "\(month): \(expenseTotal)"
        }
        
    }
    func didDeselectBarChartView(barChartView: JBBarChartView!) {
        self.detailLabel.hidden = true
        self.detailLabel.text = ""
    }
    
    func getTotalExpenseForMonthIndex(index: Int ) -> CGFloat{
        var total: CGFloat = 0.0
        for expense in self.expenses {
            if expense.expenseDate.month == index + 1 {
                if expense.expenseDate.year == self.currentDate.year {
                    total += CGFloat(expense.totalExpense.doubleValue)
                }
                
            }
        }
        return total
    }
    
    //MARK: BarChartView Delegate
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        //let expense = self.expenses[Int(index)]
        return self.getTotalExpenseForMonthIndex(Int(index))
    }
    
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        return index % 2 == 0 ? self.evenSelectionColor : self.oddSelectionColor
    }
    
    func barSelectionColorForBarChartView(barChartView: JBBarChartView!) -> UIColor! {
        return UIColor.whiteColor()
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
}
