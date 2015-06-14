//
//  ExpenseCollectionViewCell.swift
//  Condo
//
//  Created by Lucas Tenório on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class ExpenseCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var expenseView: ExpenseVectorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var selected: Bool {
        didSet{
            if var properties = self.expenseProperties {
                properties.selected = self.selected
                self.expenseProperties = properties
            }
        }
    }
    
    var expenseProperties: ExpenseDrawingProperties? {
        didSet {
            if var properties = self.expenseProperties {
                properties.selected = self.selected
                self.layer.borderWidth = 2.0
                self.layer.cornerRadius = 15.0
                //println("Selected: \(properties.selected) Color: \(properties.backgroundColor)")
                self.layer.borderColor = properties.normalShapeColor.CGColor
                self.backgroundColor = properties.backgroundColor//properties.backgroundColor
                self.expenseView.expenseProperties = properties
                self.expenseView.animateShape()
            }
        }
    }
//    var expenseType: ExpenseType? = nil {
//        didSet{
//            if let type = self.expenseType {
//                self.expenseView.expenseProperties = ExpenseDrawingProperties(type: type)
//            }
//        }
//    }

}
