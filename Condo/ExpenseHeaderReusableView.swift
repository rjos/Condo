//
//  ExpenseHeaderReusableView.swift
//  Condo
//
//  Created by Lucas Tenório on 12/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class ExpenseHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var expenseNameLabel: UILabel!
    
    @IBOutlet weak var expenseVectorView: ExpenseVectorView!
    var expenseProperties : ExpenseDrawingProperties? = nil {
        didSet{
            if let properties = self.expenseProperties {
                self.expenseNameLabel.text = properties.name
                self.backgroundColor = properties.fillColor
                self.expenseVectorView.expenseProperties = properties
                self.expenseVectorView.animateShape()
            }
        }
    }
}
