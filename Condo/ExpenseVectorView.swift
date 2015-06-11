//
//  ExpenseVectorView.swift
//  Condo
//
//  Created by Lucas Tenório on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class ExpenseVectorView: VectorView {
    var expenseType: ExpenseType? = nil {
        didSet{
            if let type = self.expenseType {
                self.drawWithType(type)
            }
        }
    }
    
    func drawWithType(type: ExpenseType) {
        switch type {
        case .Water:
            self.drawSVGWithName("agua")
            self.fillColor = UIColor.blueColor()
            self.strokeColor = UIColor.blackColor()
        case .Energy:
            self.drawSVGWithName("energia")
            self.fillColor = UIColor.yellowColor()
            self.strokeColor = UIColor.blackColor()
        case .Telephone:
            self.drawSVGWithName("conta-telefonica")
            self.fillColor = UIColor.greenColor()
            self.strokeColor = UIColor.blackColor()
        default:
            self.drawSVGWithName("settings49")
            self.fillColor = UIColor.grayColor()
            self.strokeColor = UIColor.whiteColor()
        }
    }
}
