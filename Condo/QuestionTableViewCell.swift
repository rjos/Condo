//
//  QuestionTableViewCell.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    var postHolder: PostView? = nil
    override func awakeFromNib() {
        super.awakeFromNib()

        self.postHolder = PostView.instantiateWithOwner(self)
        self.postView.fillWithSubview(postHolder!)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.contentView.backgroundColor = UIColor.condoMainBackgroundColor()
        self.mainView.backgroundColor = UIColor.whiteColor()
        // Initialization code
    }

    var post: Post? = nil {
        didSet{
            let properties = PostDrawingProperties(type: self.post!.type)
            let outlineColor = properties.outlineColor
            self.postHolder!.post = self.post
            self.postHolder!.textColor = outlineColor
            
            self.mainView.layer.cornerRadius = properties.cornerRadius
            self.mainView.layer.borderWidth = properties.lineWidth
            self.mainView.layer.borderColor = outlineColor.CGColor
            self.mainView.layer.masksToBounds = true
            
            self.tintColor = outlineColor
            self.questionSegmentedControl.tintColor = outlineColor
        }
    }
    
}
