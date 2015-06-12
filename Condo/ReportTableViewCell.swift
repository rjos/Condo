//
//  ReportTableViewCell.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    var postView: PostView? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.postView = PostView.instantiateWithOwner(self)
        self.postView!.textColor = UIColor.condoReportBackgroundColor()
        self.mainView.fillWithSubview(postView!)
        self.mainView.layer.cornerRadius = 15.0
        self.mainView.layer.borderWidth = 1.0
        self.mainView.layer.borderColor = UIColor.condoReportBackgroundColor().CGColor
        self.mainView.backgroundColor = UIColor.clearColor()
        self.mainView.layer.cornerRadius = 15.0
        self.mainView.layer.masksToBounds = true
    }
    
    var post: Post? = nil {
        didSet{
            self.postView!.post = self.post
        }
    }
    
}
