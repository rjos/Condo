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
    
    
    var expenseType: ExpenseType? = nil {
        didSet{
            if let type = self.expenseType {
                self.expenseView.expenseType = type
            }
        }
    }

}
