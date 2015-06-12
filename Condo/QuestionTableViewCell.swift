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
        self.tintColor = UIColor.condoQuestionBackgroundColor()
        self.questionSegmentedControl.tintColor = UIColor.condoQuestionBackgroundColor()
        self.postHolder = PostView.instantiateWithOwner(self)
        self.postHolder!.textColor = UIColor.condoQuestionBackgroundColor()
        self.postView.fillWithSubview(self.postHolder!)
        self.mainView.layer.cornerRadius = 15.0
        self.mainView.layer.borderWidth = 3.0
        self.mainView.layer.borderColor = UIColor.condoQuestionBackgroundColor().CGColor
        self.mainView.backgroundColor = UIColor.clearColor()
        
        self.mainView.layer.masksToBounds = true
        // Initialization code
    }

    var post: Post? = nil {
        didSet{
            self.postHolder!.post = self.post
        }
    }
    
}
