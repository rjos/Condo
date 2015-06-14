//
//  ExpenseGraphViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 14/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class ExpenseGraphViewController: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {
    @IBOutlet weak var expenseNameLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var lineChartView: JBLineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lineChartView.delegate = self
        self.lineChartView.dataSource = self
        
        self.lineChartView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    var selectedType = ExpenseType.allValues[0] {
        willSet{
            //self.lineChartView.setState(JBChartViewState.Collapsed, animated: true)
        }
        didSet{
            var p = ExpenseDrawingProperties(type: self.selectedType)
            self.view.backgroundColor = p.selectedBackgroundColor
            self.lineChartView.backgroundColor = p.selectedBackgroundColor
            self.expenseNameLabel.text = p.name
            self.lineChartView.setState(JBChartViewState.Expanded, animated: true)
        }
    }
    
    var selectedTypeProperties: ExpenseDrawingProperties {
        get{
            return ExpenseDrawingProperties(type: self.selectedType)
        }
    }
    
    //MARK: LineChartView Data Source
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return 12
    }
    
    //MARK: LineChartView Delegate
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        var test =  sin(CGFloat(horizontalIndex))
        test = abs(test)
        return test
    }
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.whiteColor()
    }
    func lineChartView(lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
    }

    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
        return 1.0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return self.selectedTypeProperties.normalBackgroundColor
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt, touchPoint: CGPoint) {
        var test =  sin(CGFloat(horizontalIndex))
        test = abs(test)
        self.detailLabel.text = "\(test)"
    }
    

}
