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
    
    var selectedType = ExpenseType.allValues[0] {
        didSet{
            var p = ExpenseDrawingProperties(type: self.selectedType)
            self.view.backgroundColor = p.selectedBackgroundColor
            self.barChartView.backgroundColor = p.selectedBackgroundColor
            self.expenseNameLabel.text = p.name
            self.barChartView.reloadData()
            self.barChartView.setState(JBChartViewState.Expanded, animated: true)
        }
    }
    
    var selectedTypeProperties: ExpenseDrawingProperties {
        get{
            return ExpenseDrawingProperties(type: self.selectedType)
        }
    }
    
    //MARK: BarChartView Data Source
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(self.expenses.count)
    }
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt, touchPoint: CGPoint) {
        let expense = self.expenses[Int(index)]
        self.detailLabel.hidden = false
        self.detailLabel.text = "\(self.month(expense.expenseDate.month)): \(expense.totalExpense)"
        println("Selected")
    }
    func didDeselectBarChartView(barChartView: JBBarChartView!) {
        self.detailLabel.hidden = true
        self.detailLabel.text = ""
    }
    
    //MARK: BarChartView Delegate
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        let expense = self.expenses[Int(index)]
        return CGFloat(expense.totalExpense.doubleValue)
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
