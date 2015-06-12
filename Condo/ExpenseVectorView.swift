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
    
    var expenseProperties: ExpenseDrawingProperties? = nil {
        didSet{
            if let properties = self.expenseProperties {
                self.drawWithProperties(properties)
            }
        }
    }
    func drawWithProperties(properties: ExpenseDrawingProperties) {
        self.drawSVGWithName(properties.svgFileName)
        self.fillColor = properties.fillColor
        self.strokeColor = properties.strokeColor
    }
}
