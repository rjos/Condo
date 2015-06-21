//
//  ExpenseGraphViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 14/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class ExpenseGraphViewController: UIViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate{
    @IBOutlet weak var expenseNameLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var lineGraph: BEMSimpleLineGraphView!
    let animationDuration = 0.7
    
    
    let evenSelectionColor = UIColor(white: 1.0, alpha: 0.8)
    let oddSelectionColor = UIColor(white: 1.0, alpha: 0.5)
    var gradient  : CGGradient?
    let currentDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lineGraph.positionYAxisRight = true
        self.lineGraph.alwaysDisplayDots = true
        self.lineGraph.enableBezierCurve = false
        self.lineGraph.enablePopUpReport = true
        self.lineGraph.enableReferenceYAxisLines = true
        self.lineGraph.enableReferenceXAxisLines = true
        self.lineGraph.labelFont = UIFont.systemFontOfSize(10.0)
        self.lineGraph.widthLine = 1.0
        self.lineGraph.animationGraphEntranceTime = CGFloat(self.animationDuration)
        self.lineGraph.lineDashPatternForReferenceYAxisLines = [2, 2]
        self.lineGraph.animationGraphStyle = BEMLineAnimation.Draw
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var components : [CGFloat] = [
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 0.0
        ]
        
        var locations : [CGFloat] = [0, 1.0]
        //let gradient = CGGradientCreateWithColors(colorSpace, components, locations)
        self.gradient = CGGradientCreateWithColorComponents(colorSpace, &components, &locations, 2)
        //let gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, componentCount)
        self.lineGraph.gradientBottom = self.gradient!
//        self.barChartView.delegate = self
//        self.barChartView.dataSource = self
        
       // self.barChartView.reloadData()
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
    let labelLeftTransform = CGAffineTransformMakeTranslation(-500, 0.0)
    var selectedType = ExpenseType.allValues[0] {
        didSet{
            var p = ExpenseDrawingProperties(type: self.selectedType)
            self.expenseNameLabel.transform = self.labelLeftTransform
            UIView.animateWithDuration(self.animationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.expenseNameLabel.transform = CGAffineTransformIdentity
                self.view.backgroundColor = p.selectedBackgroundColor
            }) { (completed) -> Void in
                
            }
//            UIView.animateWithDuration(0.5) {
//               
//                //self.barChartView.backgroundColor = p.selectedBackgroundColor
//            }
            
            self.expenseNameLabel.text = p.name
            self.lineGraph.reloadGraph()
        }
    }
    
    var selectedTypeProperties: ExpenseDrawingProperties {
        get{
            return ExpenseDrawingProperties(type: self.selectedType)
        }
    }
    
    //MARK: BEMSimpleGraphLineDataSource
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 12
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return self.getTotalExpenseForMonthIndex(index)
    }

    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String? {

        return self.month(index + 1)
    }
    
    //MARK: BarChartView Data Source
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return 12//UInt(self.expenses.count)
    }
    
    func popUpPrefixForlineGraph(graph: BEMSimpleLineGraphView) -> String {
        return "R$"
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
        case 1: return "jan"
        case 2: return "fev"
        case 3: return "mar"
        case 4: return "abr"
        case 5: return "mai"
        case 6: return "jun"
        case 7: return "jul"
        case 8: return "ago"
        case 9: return "set"
        case 10: return "out"
        case 11: return "nov"
        case 12: return "dez"
        default: return ""
        }
    }
}
