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
                let old = oldValue
                let new = self.selected
                if properties.shouldAnimateSelectionChange(old, new: new) {
                    self.expenseView.animateShape()
                }
            }
        }
    }
    
    var expenseProperties: ExpenseDrawingProperties? {
        
        didSet{
            if var properties = self.expenseProperties {

                properties.selected = self.selected
                self.layer.cornerRadius = properties.cornerRadius
                self.layer.borderWidth = properties.borderWidth
                self.layer.borderColor = properties.borderColor.CGColor
                self.backgroundColor = properties.backgroundColor
                self.expenseView.expenseProperties = properties

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
