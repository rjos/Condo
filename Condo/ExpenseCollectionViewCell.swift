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
        // Initialization code
    }
    
    override var selected: Bool {
        didSet{
            if self.selected {
                self.backgroundColor = UIColor.blackColor()
                self.expenseProperties!.selected = true
            }else{
                self.backgroundColor = UIColor.whiteColor()
                self.expenseProperties!.selected = false
            }
            self.expenseView.expenseProperties = self.expenseProperties!
            //self.expenseView.animateShape()
        }
    }
    var expenseProperties: ExpenseDrawingProperties? {
        didSet {
            if let properties = self.expenseProperties {
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
