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
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = 15.0
        
        let innerColor : UIColor
        let outerColor : UIColor
        
        if properties.selected {
            innerColor = properties.backgroundColor
            outerColor = properties.fillColor
        }else{
            innerColor = properties.fillColor
            outerColor = properties.backgroundColor
        }
        
        self.fillColor = innerColor
        self.strokeColor = innerColor
        self.layer.borderColor = innerColor.CGColor
        
        self.backgroundColor = outerColor

    }
}
